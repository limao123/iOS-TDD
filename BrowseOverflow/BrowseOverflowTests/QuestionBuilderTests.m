
//
//  QuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/19.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionBuilder.h"
#import "Question.h"

static NSString *questionJSON =
@"{"
    @"\"items\": ["
        @"{"
            @"\"tags\":["
                @"\"ios\","
                @"\"iphone\","
                @"\"swift\","
                @"\"uiscrollview\""
            @"],"
            @"\"owner\":{"
                @"\"reputation\": 456,"
                @"\"user_id\": 3515115,"
                @"\"user_type\": \"registered\","
                @"\"accept_rate\": 17,"
                @"\"profile_image\": \"https://i.stack.imgur.com/oI1Ct.jpg?s=128&g=1\","
                @"\"display_name\": \"Kamlesh Shingarakhiya\","
                @"\"link\": \"http://stackoverflow.com/users/3515115/kamlesh-shingarakhiya\""
            @"},"
            @"\"is_answered\": false,"
            @"\"view_count\": 14,"
            @"\"answer_count\": 1,"
            @"\"score\": -2,"
            @"\"last_activity_date\": 1461049881,"
            @"\"creation_date\": 1461048974,"
            @"\"question_id\": 36710706,"
            @"\"link\": \"http://stackoverflow.com/questions/36710706/background-view-color-is-set-black-when-scrollview-background-color-clear\","
            @"\"title\": \"Background View color is set black when scrollview background color clear\""
        @"}"
    @"]"
@"}";

@interface QuestionBuilderTests : XCTestCase

@end

@implementation QuestionBuilderTests{
    QuestionBuilder *questionBuilder;
    Question *question;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    questionBuilder = [[QuestionBuilder alloc] init];
    question = [[questionBuilder questionsFromJSON:questionJSON error:NULL] objectAtIndex:0];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    questionBuilder = nil;
    question = nil;
}

//不允许传递nil
- (void)testThatNilIsNotAnAcceptableParameter{
    XCTAssertThrows([questionBuilder questionsFromJSON:nil error:NULL],@"Lack of data should have been hdndled elsewhere");
}

//传入字符串不是JSON格式，返回nil
- (void)testNilReturnedWhenStringIsNotJSON{
    XCTAssertNil([questionBuilder questionsFromJSON:@"Not JSON" error:NULL],@"This parameter should not be parsable");
}

//传入字符串不是JSON格式，返回错误信息
- (void)testErrorSetWhenStringIsNotJSON{
    NSError *error = nil;
    [questionBuilder questionsFromJSON:@"Not JSON" error:&error];
    XCTAssertNotNil(error,@"An error occurred, we should be told");
}


- (void)testPassingNullErrorDoesNotCauseCrash{
    XCTAssertNoThrow([questionBuilder questionsFromJSON:@"Not JSON" error:NULL],@"Using a NULL error parameter should not be a problem");
}

-(void)testRealJSONWithoutQuestionsArrayIsError{
    NSString *jsonString = @"{\"noitems\":true}";
    XCTAssertNil([questionBuilder questionsFromJSON:jsonString error:NULL],@"No questions to parse in this JSON");
}

-(void)testRealJSONWithoutQuestionsReturnsMissingDataError {
    NSString *jsonString = @"{\"noitems\":true}";
    NSError *error = nil;
    [questionBuilder questionsFromJSON:jsonString error:&error];
    XCTAssertEqual([error code], QuestionBuilderMissingDataError,@"No questions to parse in this JSON");
}

- (void)testJSONWithOneQuestionReturnsOneQuestionObject{
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON:questionJSON error:&error];
    XCTAssertEqual([questions count], (NSUInteger)1,@"The builder should have created a question");
}

- (void)testQuestionCreatedFromJSONHasPropertiesPresentedInJSON{
    XCTAssertEqual(question.questionID, 36710706,@"The question ID should match the data we sent");
    XCTAssertEqual([question.date timeIntervalSince1970], (NSTimeInterval)1461048974,@"The date of the question should match the data");
    XCTAssertEqualObjects(question.title, @"Background View color is set black when scrollview background color clear",@"Title should match the provided data");
    XCTAssertEqual(question.score, -2,@"Score should match the data");
    Person *asker = question.asker;
    XCTAssertEqual(asker.name, @"Kamlesh Shingarakhiya",@"Looks like I should have asked this question");
    XCTAssertEqualObjects([asker.avatarURL absoluteString], @"https://i.stack.imgur.com/oI1Ct.jpg?s=128&g=1",@"");
}

- (void)testQuestionCreatedFromEmptyObjectIsStillValidObject{
    NSString *emptyQuestion = @"{\"items\":[{}]}";
    NSArray *questions = [questionBuilder questionsFromJSON:emptyQuestion error:NULL];
    XCTAssertEqual([questions count], (NSUInteger)1,@"QuestionBuilder must handle partial input");
}

- (void)testBuildingQuestionBodyWithNoDataCannotBeTried {
    XCTAssertThrows([questionBuilder fillInDetailsForQuestion: question fromJSON: nil], @"Not receiving data should have been handled earlier");
}

- (void)testBuildingQuestionBodyWithNoQuestionCannotBeTried {
    XCTAssertThrows([questionBuilder fillInDetailsForQuestion: nil fromJSON: questionJSON], @"No reason to expect that a nil question is passed");
}

- (void)testNonJSONDataDoesNotCauseABodyToBeAddedToAQuestion {
    [questionBuilder fillInDetailsForQuestion: question fromJSON: stringIsNotJSON];
    XCTAssertNil(question.body, @"Body should not have been added");
}

- (void)testJSONWhichDoesNotContainABodyDoesNotCauseBodyToBeAdded {
    [questionBuilder fillInDetailsForQuestion: question fromJSON: noQuestionsJSONString];
    XCTAssertNil(question.body, @"There was no body to add");
}

- (void)testBodyContainedInJSONIsAddedToQuestion {
    [questionBuilder fillInDetailsForQuestion: question fromJSON:questionJSON];
    XCTAssertEqualObjects(question.body, @"<p>I've been trying to use persistent keychain references.</p>", @"The correct question body is added");
}

@end
