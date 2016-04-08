//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/8.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionBuilder : NSObject
- (NSArray *)questionsFromJSON:(NSString *)objectNotation
                         error:(NSError **)error;
@end
