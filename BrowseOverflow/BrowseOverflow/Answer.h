//
//  Answer.h
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Answer : NSObject
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) Person *person;
@property (unsafe_unretained, nonatomic) NSInteger score;
@property (unsafe_unretained,getter=isAccepted,nonatomic) BOOL accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer;
@end
