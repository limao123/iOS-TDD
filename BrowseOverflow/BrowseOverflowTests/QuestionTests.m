//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"

@interface QuestionTests : XCTestCase

@end

@implementation QuestionTests{
    Question *question;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
    question.score = 42;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    question = nil;
}

- (void)testQuestionHasADate{
    NSDate *testDate = [NSDate distantPast];
    question.date = testDate;
    XCTAssertEqualObjects(question.date, testDate,@"Question needs to provide its date");
}

- (void)testQuestionsKeepScore{
    XCTAssertEqual(question.score, 42,@"Question need a numeric score");
}

- (void)testQuestionHasATitle{
    XCTAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?",@"Question should know its title");
}



@end
