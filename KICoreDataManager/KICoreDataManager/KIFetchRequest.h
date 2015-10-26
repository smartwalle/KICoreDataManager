//
//  KIFetchRequest.h
//  Kitalker
//
//  Created by Kitalker on 14-3-28.
//  Copyright (c) 2014年 杨 烽. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface KIFetchRequest : NSFetchRequest {
}
@property (nonatomic, assign) NSUInteger    pageSize;
@property (nonatomic, assign) NSUInteger    pageNumber;

- (id)initWithEntity:(NSEntityDescription *)entity;

- (id)initWithEntity:(NSEntityDescription *)entity
             context:(NSManagedObjectContext *)context;

- (void)addSortDescriptor:(NSSortDescriptor *)sortDescriptor;
- (void)addSortDescriptorWithKey:(NSString *)key ascending:(BOOL)ascending;
- (void)removeSortDescriptorWithKey:(NSString *)key;
- (void)removeAllSortDescriptor;

- (NSManagedObjectContext *)context;

- (NSArray *)fetchObjects:(NSError **)error;
- (NSManagedObject *)fetchObject:(NSError **)error;
- (NSManagedObject *)fetchObjectWithValue:(id)value forAttributes:(NSString *)attributes error:(NSError **)error;

- (NSUInteger)numberOfObjects:(NSError **)error;

@end
