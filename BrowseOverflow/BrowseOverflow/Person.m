//
//  Person.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithName:(NSString *)aName avatarLocation:(NSString *)location{
    self = [super init];
    if (self) {
        _name = [aName copy];;
        _avatarURL = [[NSURL alloc] initWithString:location];
    }
    return self;
}

@end
