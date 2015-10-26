//
//  User.m
//  Kitalker
//
//  Created by Kitalker on 14-3-28.
//  Copyright (c) 2014年 杨 烽. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic uid;
@dynamic name;
@dynamic age;
@dynamic birthday;

+ (NSString *)defaultSortAttribute {
    return @"uid";
}

@end
