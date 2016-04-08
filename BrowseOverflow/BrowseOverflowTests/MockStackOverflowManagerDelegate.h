//
//  MockStackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/8.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"

@interface MockStackOverflowManagerDelegate : NSObject<StackOverflowManagerDelegate>
@property (strong, nonatomic) NSError *fetchError;
@end
