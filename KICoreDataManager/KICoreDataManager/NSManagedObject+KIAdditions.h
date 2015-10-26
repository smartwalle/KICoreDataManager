//
//  NSManagedObject+KIAdditions.h
//  Kitalker
//
//  Created by Kitalker on 14-3-28.
//  Copyright (c) 2014年 杨 烽. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (KIAdditions)

+ (NSString *)entityName;

/*子类重写此方法*/
+ (NSString *)defaultSortAttribute;

+ (NSEntityDescription *)entity;

+ (NSEntityDescription *)entityWithContext:(NSManagedObjectContext *)context;

/*查询出所有的NSManagedObject*/
+ (NSArray *)objects;

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context;

/*根据条件查询出NSManagedObject*/
+ (NSArray *)objectsWithPredicate:(NSPredicate *)predicate;

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate;

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context predicate:(NSPredicate *)predicate pageSize:(NSUInteger)pageSize;

+ (NSArray *)objectsWithFormat:(NSString *)fmt,...;

+ (NSArray *)objectsWithPageSize:(NSUInteger)pageSize Format:(NSString *)fmt,...;

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context format:(NSString *)fmt,...;

+ (NSArray *)objectsWithContext:(NSManagedObjectContext *)context pageSize:(NSUInteger)pageSize format:(NSString *)fmt,...;

+ (instancetype)firstObject;

+ (instancetype)firstObjectWithContext:(NSManagedObjectContext *)context;

+ (instancetype)firstObjectWithFormat:(NSString *)fmt,...;

+ (instancetype)firstObjectWithContext:(NSManagedObjectContext *)context format:(NSString *)fmt,...;

+ (instancetype)lastObject;

+ (instancetype)lastObjectWithContext:(NSManagedObjectContext *)context;

+ (instancetype)lastObjectWithFormat:(NSString *)fmt,...;

+ (instancetype)lastObjectWithContext:(NSManagedObjectContext *)context format:(NSString *)fmt,...;

/*新建一个NSManagedObject*/
+ (instancetype)insertWithContext:(NSManagedObjectContext *)context;

/*新建一个NSManagedObject之前，先根据value和attribute进行查找，
 如果查找到对象，则返回该对象，如果没有查找到，则新建一个对象*/
+ (instancetype)insertWithContext:(NSManagedObjectContext *)context
                        withValue:(id)value
                     forAttribute:(NSString *)attribute;

- (void)remove;

- (void)removeFromContext:(NSManagedObjectContext *)context;

+ (void)removeAll;

+ (void)removeAllFromContext:(NSManagedObjectContext *)context;

/* 
 将子线程的 NSManagedObject 对象转换为主线程的 NSManagedObject
 */
+ (NSArray *)convertObjectsToMainContext:(NSArray *)objects;

+ (id)convertObjectToMainContext:(NSManagedObject *)object;

@end
