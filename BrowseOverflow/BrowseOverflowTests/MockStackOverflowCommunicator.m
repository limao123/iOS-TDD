//
//  MockStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/8.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator{
    BOOL wasAskedToFetchQuestions;
}

- (void)searchForQuestionsWithTag:(NSString *)tag{
    wasAskedToFetchQuestions = YES;
}

- (BOOL)wasAskedToFetchQuestions{
    return wasAskedToFetchQuestions;
}

@end
