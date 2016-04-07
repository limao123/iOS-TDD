//
//  Question.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "Question.h"

@implementation Question

- (instancetype)init{
    self = [super init];
    if (self) {
        answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer{
    [answerSet addObject:answer];
}

- (NSArray *)answers{
    return [[answerSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

@end
