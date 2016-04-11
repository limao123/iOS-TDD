//
//  StackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/8.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"

@protocol StackOverflowManagerDelegate<NSObject>
- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceivedQuestions:(NSArray *)questions;
@end
