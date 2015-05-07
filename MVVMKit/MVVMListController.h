// 
// MVVMListController.h
// MVVMKit
//
// Created by Denys Kotelovych on 5/7/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMController.h"
#import "MVVMListViewModel.h"

@interface MVVMListController : MVVMController
  <
  UITableViewDataSource,
  UITableViewDelegate
  >

@property (nonatomic, strong, readonly) MVVMListViewModel *viewModel;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (instancetype)initWithViewModel:(MVVMListViewModel *)viewModel
                      cellNibName:(NSString *)cellName
                   cellIdentifier:(NSString *)identifier;

@end