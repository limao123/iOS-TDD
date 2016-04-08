//
//  FakeQuestionBuilder.h
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/8.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "QuestionBuilder.h"

@interface FakeQuestionBuilder : QuestionBuilder
@property (copy, nonatomic) NSString *JSON;
@property (copy, nonatomic) NSArray *arrayToReturn;
@property (copy, nonatomic) NSError *errorToSet;
@end
