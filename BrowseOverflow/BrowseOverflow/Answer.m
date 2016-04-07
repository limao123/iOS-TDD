//
//  Answer.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "Answer.h"

@implementation Answer
- (NSComparisonResult)compare:(Answer *)otherAnswer{
    if (self.accepted && !(otherAnswer.accepted)) {
        return NSOrderedAscending;
    } else if (!self.accepted && otherAnswer.accepted){
        return NSOrderedDescending;
    }
    
    if (self.score > otherAnswer.score) {
        return NSOrderedAscending;
    } else if (self.score < otherAnswer.score){
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

@end
