//
//  TopicTests.m
//  BrowseOverflow
//
//  Created by 林涛 on 16/4/6.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Topic.h"

@interface TopicTests : XCTestCase{
    Topic *topic;
}

@end

@implementation TopicTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iPhone"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    topic = nil;
}


//测试能否创建实例
- (void)testThatTopicExists {
    XCTAssertNotNil(topic,@"should be able to create a Topic instance");
}

#pragma mark - 测试属性能否赋值
//是否包含name属性
- (void)testThatTopicCanBeNamed{
    XCTAssertEqualObjects(topic.name, @"iPhone",@"the topic should have the name I gave it");
}

//是否包含tag属性
- (void)testThatTopicHasATag{
    XCTAssertEqualObjects(topic.tag, @"iPhone",@"the Topic should have the tag I gave it");
}

//问题列表返回的是否是数组
- (void)testForAListOfQuestions{
    XCTAssertTrue([[topic recentQuestions] isKindOfClass:[NSArray class]],@"Topic should provide a list of recent questions");
}

//没有添加question时，最近问题列表数量是否为0
- (void)testForInitiallyEmptyQuestionList{
    XCTAssertEqual([[topic recentQuestions] count], (NSInteger)0, @"No questions added yet, count should be zero");
}

//测试添加question是否正确
- (void)testAddingAQuestionToTheList{
    Question *question = [[Question alloc] init];
    [topic addQuestion:question];
    XCTAssertEqual([[topic recentQuestions] count], (NSInteger)1,@"Add a question, and the count of questions should go up");
}

//测试问题排列顺序是否按年月排序
- (void)testQuestionsAreListedChronologically{
    Question *q1 = [[Question alloc] init];
    q1.date = [NSDate distantPast];
    
    Question *q2 = [[Question alloc] init];
    q2.date = [NSDate distantFuture];
    
    [topic addQuestion:q1];
    [topic addQuestion:q2];
    
    NSArray *questions = [topic recentQuestions];
    Question *listedFirst = [questions objectAtIndex:0];
    Question *listedSecond = [questions objectAtIndex:1];
    
    XCTAssertEqual([listedFirst.date laterDate:listedSecond.date], listedFirst.date, @"The later question should appear first in the list");
}

//测试问题列表是否最多只能含20个问题
- (void)testLimitOf20Questions{
    Question *q1 = [[Question alloc] init];
    for (int i = 0; i < 25; i++) {
        [topic addQuestion:q1];
    }
    XCTAssertTrue([[topic recentQuestions] count] < 21, @"There should never be more than twenty questions");
}


@end
