//
//  AnswerTests.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Answer.h"

@interface AnswerTests : XCTestCase

@end

@implementation AnswerTests{
    Answer *answer;
    Answer *otherAnswer;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    answer = [[Answer alloc] init];
    answer.text = @"The answer is 42";
    answer.person = [[Person alloc] initWithName:@"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    answer.score = 42;
    otherAnswer = [[Answer alloc] init];
    otherAnswer.text = @"I haveer the answer you need";
    otherAnswer.score = 42;
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    answer = nil;
}

- (void)testAnswerHasSomeText{
    XCTAssertEqualObjects(answer.text, @"The answer is 42",@"Answers need to contain some text");
}

- (void)testSomeoneProvidedTheAnswer{
    XCTAssertTrue([answer.person isKindOfClass:[Person class]],@"A Person gave this Answer");
}

- (void)testAnswersNotAcceptedByDefault{
    XCTAssertFalse(answer.accepted,@"Answer not accepted by default");
}

- (void)testAnswerCanBeAccepted{
    XCTAssertNoThrow(answer.accepted = YES, @"It is possible to accept an answer");
}

- (void)testAnswerHasAScore{
    XCTAssertTrue(answer.score == 42,@"Answer's score can be retrieved");
}

- (void)testAcceptedAnswerComesBeforeUnaccepted{
    otherAnswer.accepted = YES;
    otherAnswer.score = answer.score + 10;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending,@"Accepted answer should come first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending,@"Unaccepted answer should come last");
}

- (void)testAnswersWithEqualScoresCompareEqually{
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedSame,@"Both answers of equal rank");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedSame,@"Each answer has the same rank");
}

- (void)testLowerScoringAnswerComsAfterHigher{
    otherAnswer.score = answer.score + 10;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending,@"Higher score comes first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending,@"Lower score comes last");
}
@end
