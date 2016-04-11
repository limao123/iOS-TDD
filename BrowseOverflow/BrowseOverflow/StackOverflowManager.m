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

//正确设置代理
- (void)setDelegate:(id)newDelegate{
    if (newDelegate && ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil] raise];
    }
    _delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic{
    [self.communicator searchForQuestionsWithTag:[topic tag]];
}

//获取网络数据失败返回错误
- (void)searchingForQuestionsFailedWithError:(NSError *)error{
    [self tellDelegateAloutQuestionSearchError:error];
}

//获取网络数据后，数据无效或者处理失败返回错误
- (void)receivedQuestionsJSON:(NSString *)objectNotation{
    NSError *error = nil;
    NSArray *questions = [self.questionBuilder questionsFromJSON:objectNotation error:&error];
    if (!questions) {
        [self tellDelegateAloutQuestionSearchError:error];
    } else {
        [self.delegate didReceivedQuestions:questions];
    }
}

- (void)tellDelegateAloutQuestionSearchError:(NSError *)underlyingError{
    NSDictionary *errorInfo = nil;
    if (underlyingError) {
        errorInfo = [NSDictionary dictionaryWithObject: underlyingError forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerError code: StackOverflowManagerErrorQuestionSearchCode userInfo: errorInfo];
    [self.delegate fetchingQuestionsFailedWithError:reportableError];

}
@end

