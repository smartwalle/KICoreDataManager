//
//  KICoreDataViewController.h
//  Kitalker
//
//  Created by Kitalker on 14-3-28.
//  Copyright (c) 2014年 杨 烽. All rights reserved.
//

#import "BaseTableViewController.h"
#import "KICoreDataManager.h"
#import "NSManagedObject+KIAdditions.h"
#import "NSManagedObjectContext+KIAdditions.h"
#import "KIFetchRequest.h"

#import "User.h"

@interface KICoreDataViewController : BaseTableViewController {
    NSFetchedResultsController  *_fetchResultController;
}

@end
