//
//  PersonTests.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTests : XCTestCase

@end

@implementation PersonTests{
    Person *person;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    person = [[Person alloc] initWithName:@"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    person = nil;
}

- (void)testThatPersonHasTheRightName{
    XCTAssertEqualObjects(person.name, @"Graham Lee",@"expecting a person to provide its name");
}

- (void)testThatPersonHasAnAvatarURL{
    NSURL *url = person.avatarURL;
    XCTAssertEqualObjects([url absoluteString], @"http://example.com/avatar.png",@"The Person's avatar should be represented by a URL");
}
@end
