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

//测试是否含text属性
- (void)testAnswerHasSomeText{
    XCTAssertEqualObjects(answer.text, @"The answer is 42",@"Answers need to contain some text");
}

//测试是否含Person属性
- (void)testSomeoneProvidedTheAnswer{
    XCTAssertTrue([answer.person isKindOfClass:[Person class]],@"A Person gave this Answer");
}

//测试accepted默认值是否正确
- (void)testAnswersNotAcceptedByDefault{
    XCTAssertFalse(answer.accepted,@"Answer not accepted by default");
}

//测试accepted能否被赋值
- (void)testAnswerCanBeAccepted{
    XCTAssertNoThrow(answer.accepted = YES, @"It is possible to accept an answer");
}

//测试score是否能被获取
- (void)testAnswerHasAScore{
    XCTAssertTrue(answer.score == 42,@"Answer's score can be retrieved");
}

//测试accepted为YES的答案是否排序accepted为NO的前面
- (void)testAcceptedAnswerComesBeforeUnaccepted{
    otherAnswer.accepted = YES;
    otherAnswer.score = answer.score + 10;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending,@"Accepted answer should come first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending,@"Unaccepted answer should come last");
}

//测试相同分数的答案比较返回值是否正确
- (void)testAnswersWithEqualScoresCompareEqually{
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedSame,@"Both answers of equal rank");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedSame,@"Each answer has the same rank");
}

//测试不同分数的答案比较返回值是否正确
- (void)testLowerScoringAnswerComsAfterHigher{
    otherAnswer.score = answer.score + 10;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending,@"Higher score comes first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending,@"Lower score comes last");
}
@end
