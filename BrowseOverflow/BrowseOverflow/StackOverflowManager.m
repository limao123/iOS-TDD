//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/8.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import "StackOverflowManager.h"

NSString *StackOverflowManagerError = @"StackOverflowManagerError";


@implementation StackOverflowManager

- (void)setDelegate:(id)newDelegate{
    if (newDelegate && ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil] raise];
    }
    _delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic{
    [self.communicator searchForQuestionsWithTag:[topic tag]];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorQuestionSearchCode userInfo:errorInfo];
    [self.delegate fetchingQuestionsFailedWithError:reportableError];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation{
    NSArray *questions = [self.questionBuilder questionsFromJSON:objectNotation error:NULL];
}
@end

