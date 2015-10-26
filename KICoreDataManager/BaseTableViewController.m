//
//  BaseTableViewController.m
//  Kitalker
//
//  Created by Kitalker on 14-3-28.
//  Copyright (c) 2014年 杨 烽. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)dealloc {
    _dataSource = nil;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    if (KI_IOS_7_OR_LATER) {
//        [self setEdgesForExtendedLayout:UIRectEdgeNone];
//        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
}

@end
