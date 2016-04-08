//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/8.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate

- (void)fetchingQuestionsFailedWithError:(NSError *)error{
    self.fetchError = error;
}

@end
