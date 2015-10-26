//
//  KICoreDataViewController.m
//  Kitalker
//
//  Created by Kitalker on 14-3-28.
//  Copyright (c) 2014年 杨 烽. All rights reserved.
//

#import "KICoreDataViewController.h"

@interface KICoreDataViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation KICoreDataViewController

- (void)dealloc {
    _fetchResultController = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *importItem = [[UIBarButtonItem alloc] initWithTitle:@"导入"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(import)];
    
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"清除"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(clear)];
    self.navigationItem.rightBarButtonItems = @[importItem, clearItem];
    
    NSManagedObjectContext *mainContext = [[KICoreDataManager sharedInstance] mainManagedObjectContext];
    KIFetchRequest *fetchRequest = [[KIFetchRequest alloc] initWithEntity:[User entity] context:mainContext];
    _fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                 managedObjectContext:mainContext
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
    [_fetchResultController setDelegate:self];
    [_fetchResultController performFetch:nil];
    
    
}

- (void)import {
    dispatch_async(dispatch_queue_create("insert-user", 0), ^{
        NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
        for (int i=0; i<10000; i++) {
            User *user = [User insertWithContext:context withValue:[NSNumber numberWithInt:i] forAttribute:@"uid"];
            user.uid = [NSNumber numberWithInt:i];
            user.age = [NSNumber numberWithInt:i];
            user.name = [NSString stringWithFormat:@"name-%d", i];
            [context commitUpdate];
            sleep(1);
        }
    });
}

- (void)clear {
    dispatch_async(dispatch_queue_create("delete-user", 0), ^{
        NSManagedObjectContext *context = [[KICoreDataManager sharedInstance] createManagedObjectContext];
        NSArray *items = [User objectsWithContext:context];
        
        for (User *u in items) {
            [u removeFromContext:context];
        }
        
        [context commitUpdate];
    });
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case NSFetchedResultsChangeMove: {
            
        }
            break;
        case NSFetchedResultsChangeUpdate: {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        default:
            break;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetchResultController.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CELL_IDENTIFIER = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    User *user = [_fetchResultController.fetchedObjects objectAtIndex:indexPath.row];
    [cell.textLabel setText:user.name];
    
    return cell;
}

@end
