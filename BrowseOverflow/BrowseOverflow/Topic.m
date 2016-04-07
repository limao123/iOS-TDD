//
//  Topic.m
//  BrowseOverflow
//
//  Created by 林涛 on 16/4/6.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "Topic.h"


@implementation Topic{
    NSArray *questions;
}


- (instancetype)initWithName:(NSString *)newName tag:(NSString *)tag{
    if (self = [super init]) {
        _name = [newName copy];
        _tag = [tag copy];
        questions = [[NSArray alloc] init];
    }
    return self;
}

- (NSArray *)recentQuestions{
    
    return [self sortQuestionsLatestFirst:questions];
}

- (void)addQuestion:(Question *)question{
    NSArray *newQuestions = [questions arrayByAddingObject:question];
    if (newQuestions.count > 20) {
        newQuestions = [self sortQuestionsLatestFirst:newQuestions];
        newQuestions = [newQuestions subarrayWithRange:NSMakeRange(0, 20)];
    }
    questions = newQuestions;
}

- (NSArray *)sortQuestionsLatestFirst:(NSArray *)questionList{
    return [questionList sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Question *q1 = (Question *)obj1;
        Question *q2 = (Question *)obj2;
        return [q2.date compare:q1.date];
    }];
}
@end
