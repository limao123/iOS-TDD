//
//  Topic.h
//  BrowseOverflow
//
//  Created by 林涛 on 16/4/6.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface Topic : NSObject
@property (copy,readonly,nonatomic) NSString *name;
@property (copy,readonly,nonatomic) NSString *tag;

- (instancetype)initWithName:(NSString *)newName tag:(NSString *)tag;
- (NSArray *)recentQuestions;
- (void)addQuestion:(Question *)question;
@end

