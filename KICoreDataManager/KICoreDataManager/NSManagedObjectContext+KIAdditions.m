//
//  NSManagedObjectContext+KIAdditions.m
//  Kitalker
//
//  Created by Kitalker on 14-3-28.
//  Copyright (c) 2014年 杨 烽. All rights reserved.
//

#import "NSManagedObjectContext+KIAdditions.h"
#import "KICoreDataManager.h"

@implementation NSManagedObjectContext (KIAdditions)

- (BOOL)commitUpdate {
    return [self commitUpdate:nil];
}

- (BOOL)commitUpdate:(NSError **)error {
    BOOL saveStatus = NO;
    if ([self hasChanges]) {
        saveStatus = [self save:error];
    }
    
    NSManagedObjectContext *mainManagedObjectContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    NSManagedObjectContext *rootManagedObjectContext = [[KICoreDataManager sharedInstance] rootManagedObjectContext];
    
    if ([mainManagedObjectContext hasChanges]) {
        [mainManagedObjectContext performBlockAndWait:^{
            [mainManagedObjectContext save:error];
        }];
    }
    
    if ([rootManagedObjectContext hasChanges]) {
        [rootManagedObjectContext performBlock:^{
            [rootManagedObjectContext save:error];
        }];
    }
    
    return saveStatus;
}

+ (NSManagedObjectContext *)mainManagedObjectContext {
    return [[KICoreDataManager sharedInstance] mainManagedObjectContext];
}

+ (NSManagedObjectContext *)createManagedObjectContext {
    return [[KICoreDataManager sharedInstance] createManagedObjectContext];
}

@end
