//
//  QuestionCreationTests.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/8.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "Topic.h"
#import "FakeQuestionBuilder.h"

@interface QuestionCreationTests : XCTestCase

@end

@implementation QuestionCreationTests{
@private
    StackOverflowManager *mgr;
    MockStackOverflowManagerDelegate *delegate;
    FakeQuestionBuilder *questionBuilder;
    NSError *underlyingError;
    NSArray *questionArray;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    questionBuilder = [[FakeQuestionBuilder alloc] init];
    questionBuilder.arrayToReturn = nil;
    mgr.questionBuilder = questionBuilder;
    
    Question *question = [[Question alloc] init];
    questionArray = [NSArray arrayWithObject:question];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    mgr = nil;
    delegate = nil;
    underlyingError = nil;
    questionArray = nil;
}

//设置代理、获取数据、传递数据、传递数据错误处理

//确保代理类不能为空
- (void)testNonConformingObjectCannotBeDelegate{
    XCTAssertThrows(mgr.delegate = (id<StackOverflowManagerDelegate>)[NSNull null],@"NSNull should not bu used as the delegate as doesn't conform to the delegate protocol");
}

//测试正确的代理类能否被正确设置
- (void)testConformingObjectCanBeDelegate{
    id <StackOverflowManagerDelegate> delegate = [[MockStackOverflowManagerDelegate alloc] init];
    XCTAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

//测试是否允许代理为nil
- (void)testManagerAceptsNilAsDelegate{
    XCTAssertNoThrow(mgr.delegate = nil,@"Ti should be acceptabel to use nil as an object's delegate");
}

//测试是否能获取数据
- (void)testAskingForQuestionMeansRequestingData{
    MockStackOverflowCommunicator *communicator = [[MockStackOverflowCommunicator alloc] init];
    mgr.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionsOnTopic:topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions],@"The communicator should need to fetch data.");
}

//测试错误是否能被返回，以更高层视角来报告错误信息
- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator{
    MockStackOverflowManagerDelegate *delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    NSError *underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

//取出底层错误
- (void)testErrorReturnedToDelegateDocumentsUnderlyingError{
    MockStackOverflowManagerDelegate *delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    NSError *underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], underlyingError,@"The underlying error should be available to client code");
}

//测试JSON字符串能正确传递过去
- (void)testQuestionJSONIsPassedToQuestionBuilder{
    FakeQuestionBuilder *builder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = builder;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects(builder.JSON, @"Fake JSON",@"Downloaded JSON is sent to the builder");
    mgr.questionBuilder = nil;
}

//测试当创建失败时可以返回错误
- (void)testDelegateNofifiedOfErrorWhenQuestionBuilderFails{
    FakeQuestionBuilder *builder = [[FakeQuestionBuilder alloc] init];
    builder.arrayToReturn = nil;
    builder.errorToSet = underlyingError;
    mgr.questionBuilder = builder;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey],@"The delegate should have found out about the error");
    mgr.questionBuilder = nil;
}

//有数据返回时不会返回数据
- (void)testDelegateNotToldAbouErrorWhenQuestionsReceived{
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNil([delegate fetchError],@"No error should be received on success");
}

- (void)testDelegateReceivesTheQuestionsDiscoveredByManager {
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects(delegate.receivedQuestions, questionArray,@"The manager should have sent its questions to the delegate");
}

- (void)testEmpthArrayIsPassedToDelegate{
    questionBuilder.arrayToReturn = [NSArray array];
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects(delegate.receivedQuestions, [NSArray array],@"Returning an empty array is not an error");
}
@end

