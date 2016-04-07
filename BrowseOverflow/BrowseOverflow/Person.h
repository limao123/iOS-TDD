//
//  Person.h
//  BrowseOverflow
//
//  Created by bmob-LT on 16/4/7.
//  Copyright © 2016年 bmob-LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *avatarURL;

- (instancetype)initWithName:(NSString *)aName avatarLocation:(NSString *)location;
@end
