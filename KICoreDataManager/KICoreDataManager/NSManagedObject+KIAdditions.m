//
//  NSManagedObject+KIAdditions.m
//  Kitalker
//
//  Created by Kitalker on 14-3-28.
//  Copyright (c) 2014年 杨 烽. All rights reserved.
//

#import "NSManagedObject+KIAdditions.h"
#import "KICoreDataManager.h"
#import "KIFetchRequest.h"

@implementation NSManagedObject (KIAdditions)

+ (NSString *)entityName {
    return NSStringFromClass([self class]);
}

+ (NSString *)defaultSortAttribute {
//    NSString *errorMsg = [NSString stringWithFormat:@"%@ 必须重写 [NSManagedObject defaultSortAttribute] 方法", [self entityName]];
//    NSAssert(NO, errorMsg);
    return nil;
}

+ (NSEntityDescription *)entity {
    NSEntityDescription *entityDescription;
    if ([NSThread isMainThread]) {
        entityDescription = [NSEntityDescription entityForName:[self entityName]
                                        inManagedObjectContext:[NSManagedObjectContext mainManagedObjectContext]];
    } else {
        entityDescription = [NSEntityDescription entityForName:[self entityName]
                                        inManagedObjectContext:[NSManagedObjectContext createManagedObjectContext]];
    }
    return entityDescription;
}

+ (NSEntityDescription *)entityWithContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription entityForName:[self entityName]
                       inManagedObjectContext:context];
}

+ (NSArray *)objects {
    return [self objectsWithPredicate:nil];
}

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context {
    return [self objectsWithContext:context predicate:nil];
}

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate {
    return [self objectsWithContext:context predicate:predicate pageSize:0];
}

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate pageSize:(NSUInteger)pageSize {
    KIFetchRequest *fetchRequest = nil;
    if (context == nil) {
        return nil;
    }
    
    fetchRequest = [[KIFetchRequest alloc] initWithEntity:[self entityWithContext:context] context:context];
    
    if (predicate != nil) {
        [fetchRequest setPredicate:predicate];
    }
    
    if (pageSize > 0) {
        [fetchRequest setPageNumber:0];
        [fetchRequest setPageSize:pageSize];
    }
    
    return [fetchRequest fetchObjects:nil];
}

+ (NSArray *)objectsWithPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *context = nil;
    if ([NSThread isMainThread]) {
        context = [KICoreDataManager sharedInstance].mainManagedObjectContext;
    } else {
        context = [KICoreDataManager sharedInstance].createManagedObjectContext;
    }
    return [self objectsWithContext:context predicate:predicate];
}

+ (NSArray *)objectsWithFormat:(NSString *)fmt,... {
    va_list args;
    va_start(args, fmt);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:fmt arguments:args];
    va_end(args);
    
    return [self objectsWithPredicate:predicate];
}

+ (NSArray *)objectsWithPageSize:(NSUInteger)pageSize Format:(NSString *)fmt,... {
    va_list args;
    va_start(args, fmt);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:fmt arguments:args];
    va_end(args);
    
    NSManagedObjectContext *context = nil;
    if ([NSThread isMainThread]) {
        context = [KICoreDataManager sharedInstance].mainManagedObjectContext;
    } else {
        context = [KICoreDataManager sharedInstance].createManagedObjectContext;
    }
    return [self objectsWithContext:context predicate:predicate pageSize:pageSize];
}

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context format:(NSString *)fmt,... {
    va_list args;
    va_start(args, fmt);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:fmt arguments:args];
    va_end(args);
    return [self objectsWithContext:context predicate:predicate];
}

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context pageSize:(NSUInteger)pageSize format:(NSString *)fmt,... {
    va_list args;
    va_start(args, fmt);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:fmt arguments:args];
    va_end(args);
    return [self objectsWithContext:context predicate:predicate pageSize:pageSize];
}

+ (instancetype)firstObject {
    return [[self objects] firstObject];
}

+ (instancetype)firstObjectWithContext:(NSManagedObjectContext *)context {
    return [[self objectsWithContext:context] firstObject];
}

+ (instancetype)firstObjectWithFormat:(NSString *)fmt, ... {
    va_list args;
    va_start(args, fmt);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:fmt arguments:args];
    va_end(args);
    return [[self objectsWithPredicate:predicate] firstObject];
}

+ (instancetype)firstObjectWithContext:(NSManagedObjectContext *)context format:(NSString *)fmt,... {
    va_list args;
    va_start(args, fmt);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:fmt arguments:args];
    va_end(args);
    return [[self objectsWithContext:context predicate:predicate] firstObject];
}

+ (instancetype)lastObject {
    return [[self objects] lastObject];
}

+ (instancetype)lastObjectWithContext:(NSManagedObjectContext *)context {
    return [[self objectsWithContext:context] lastObject];
}

+ (instancetype)lastObjectWithFormat:(NSString *)fmt,... {
    va_list args;
    va_start(args, fmt);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:fmt arguments:args];
    va_end(args);
    return [[self objectsWithPredicate:predicate] lastObject];
}

+ (instancetype)lastObjectWithContext:(NSManagedObjectContext *)context format:(NSString *)fmt,... {
    va_list args;
    va_start(args, fmt);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:fmt arguments:args];
    va_end(args);
    return [[self objectsWithContext:context predicate:predicate] lastObject];
}

+ (instancetype)insertWithContext:(NSManagedObjectContext *)context {
    NSManagedObject *object = [[NSManagedObject alloc] initWithEntity:[self entityWithContext:context]
                                       insertIntoManagedObjectContext:context];
    return object;
}

+ (instancetype)insertWithContext:(NSManagedObjectContext *)context
              withValue:(id)value
           forAttribute:(NSString *)attribute {
    KIFetchRequest *request = [[KIFetchRequest alloc] initWithEntity:[self entityWithContext:context] context:context];
    [request setPageSize:1];
    
    NSManagedObject *object = [request fetchObjectWithValue:value forAttributes:attribute error:nil];
    if (object == nil) {
        object = [self insertWithContext:context];
        [object setValue:value forKey:attribute];
    }
    return object;
}

- (void)remove {
    [self.managedObjectContext deleteObject:self];
}

- (void)removeFromContext:(NSManagedObjectContext *)context {
    if (context == nil) {
        return ;
    }
    [context deleteObject:self];
}

+ (void)removeAll {
    NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    [self removeAllFromContext:context];
}

+ (void)removeAllFromContext:(NSManagedObjectContext *)context {
     NSArray *objects = [self objectsWithContext:context];
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSManagedObject *object = (NSManagedObject *)obj;
        [context deleteObject:object];
    }];
    [context commitUpdate];
}

+ (NSArray *)convertObjectsToMainContext:(NSArray *)objects {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSManagedObjectContext *mainContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSManagedObject *mobj = (NSManagedObject *)obj;
        if (mobj.managedObjectContext != mainContext) {
            mobj = [mainContext objectWithID:mobj.objectID];
        }
        [results addObject:mobj];
    }];
    return results;
}

+ (id)convertObjectToMainContext:(NSManagedObject *)object {
    NSManagedObjectContext *mainContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    NSManagedObject *result = object;
    if (object.managedObjectContext != mainContext) {
        result = [mainContext objectWithID:object.objectID];
    }
    return result;
}

@end
