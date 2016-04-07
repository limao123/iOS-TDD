//
//  Question.h
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"

@interface Question : NSObject{
    NSMutableSet *answerSet;
}
@property (strong, nonatomic) NSDate *date;
@property (copy, nonatomic) NSString *title;
@property (unsafe_unretained, nonatomic) NSInteger score;
@property (copy,readonly,nonatomic) NSArray *answers;

- (void)addAnswer:(Answer *)answer;
@end
