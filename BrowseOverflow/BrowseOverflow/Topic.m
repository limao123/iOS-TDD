//
//  Topic.m
//  BrowseOverflow
//
//  Created by 林涛 on 16/4/6.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "Topic.h"


@implementation Topic


- (instancetype)initWithName:(NSString *)newName{
    if (self = [super init]) {
        _name = [newName copy];
    }
    return self;
}
@end
