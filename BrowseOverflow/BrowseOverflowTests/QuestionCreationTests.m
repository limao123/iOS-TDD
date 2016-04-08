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
    MockStackOverflowManagerDelegate *delegete;
    NSError *underlyingError;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    mgr = [[StackOverflowManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    mgr = nil;
}

- (void)testNonConformingObjectCannotBeDelegate{
    XCTAssertThrows(mgr.delegate = (id<StackOverflowManagerDelegate>)[NSNull null],@"NSNull should not bu used as the delegate as doesn't conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate{
    id <StackOverflowManagerDelegate> delegate = [[MockStackOverflowManagerDelegate alloc] init];
    XCTAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void)testManagerAceptsNilAsDelegate{
    XCTAssertNoThrow(mgr.delegate = nil,@"Ti should be acceptabel to use nil as an object's delegate");
}

- (void)testAskingForQuestionMeansRequestingData{
    MockStackOverflowCommunicator *communicator = [[MockStackOverflowCommunicator alloc] init];
    mgr.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionsOnTopic:topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions],@"The communicator should need to fetch data.");
}

//以更高层视角来报告错误信息
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

- (void)testQuestionJSONIsPassedToQuestionBuilder{
    FakeQuestionBuilder *builder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = builder;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects(builder.JSON, @"Fake JSON",@"Downloaded JSON is sent to the builder");
    mgr.questionBuilder = nil;
}
@end
