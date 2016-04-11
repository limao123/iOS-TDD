//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/8.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "FakeQuestionBuilder.h"

@implementation FakeQuestionBuilder
- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error{
    self.JSON = objectNotation;
    if (error) {
        *error = self.errorToSet;
    }
    return self.arrayToReturn;
}
@end
