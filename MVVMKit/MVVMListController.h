// 
// MVVMListController.h
// MVVMKit
//
// Created by Denys Kotelovych on 5/7/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMController.h"
#import "MVVMListViewModel.h"

@class MVVMListController;

@protocol MVVMListControllerFetchingDelegate <NSObject>

 @optional
- (void)MVVMListControllerFetchingStarted:(MVVMListController *)controller;
- (void)MVVMListControllerFetchingFailed:(MVVMListController *)controller error:(NSError *)error;
- (void)MVVMListControllerFetchingEnded:(MVVMListController *)controller;

@end

@interface MVVMListController : MVVMController
  <
  UITableViewDataSource,
  UITableViewDelegate
  >

@property (nonatomic, strong, readonly) MVVMListViewModel *viewModel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id <MVVMListControllerFetchingDelegate> delegate;

- (instancetype)initWithViewModel:(MVVMListViewModel *)viewModel
                      cellNibName:(NSString *)cellName
                   cellIdentifier:(NSString *)identifier;

- (void)reloadData;

@end