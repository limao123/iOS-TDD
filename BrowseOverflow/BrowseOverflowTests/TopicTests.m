//
//  TopicTests.m
//  BrowseOverflow
//
//  Created by 林涛 on 16/4/6.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Topic.h"

@interface TopicTests : XCTestCase

@end

@implementation TopicTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testThatTopicExists {
    Topic *newTopic = [[Topic alloc] init];
    XCTAssertNil(newTopic,@"should be able to create a Topic instance");
}

- (void)testThatTopicCanBeNamed{
    Topic *namedTopic = [[Topic alloc] initWithName:@"iPhone"];
    XCTAssertEqualObjects(namedTopic.name, @"iPhone",@"the topic should have the name I gave it");
}
@end
