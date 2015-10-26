//
//  NSManagedObjectContext+KIAdditions.h
//  Kitalker
//
//  Created by Kitalker on 14-3-28.
//  Copyright (c) 2014年 杨 烽. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (KIAdditions)

/*提交所有的更新操作，包括delete, insert*/
- (BOOL)commitUpdate;

- (BOOL)commitUpdate:(NSError **)error;


+ (NSManagedObjectContext *)mainManagedObjectContext;

+ (NSManagedObjectContext *)createManagedObjectContext;

@end
