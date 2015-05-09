// 
// MVVMListController.m
// MVVMKit
//
// Created by Denys Kotelovych on 5/7/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMListController.h"
#import "MVVMCell.h"

@interface MVVMListController ()

@property (nonatomic, strong) NSString *cellNibName;
@property (nonatomic, strong) NSString *cellIdentifier;

@end

@implementation MVVMListController

@dynamic viewModel;

#pragma mark - Init Methods

- (instancetype)initWithViewModel:(MVVMListViewModel *)viewModel
                      cellNibName:(NSString *)cellNibName
                   cellIdentifier:(NSString *)cellIdentifier {
  self = [super initWithViewModel:viewModel];
  if (!self) return nil;
  self.cellNibName = cellNibName;
  self.cellIdentifier = cellIdentifier;
  return self;
}

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.tableView
    registerNib:[UINib nibWithNibName:self.cellNibName bundle:nil]
    forCellReuseIdentifier:self.cellIdentifier];

  [self.viewModel fetch].then(^{
    [self.tableView reloadData];
  });
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell <MVVMCell> *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
  [cell reloadWithViewModel:[self.viewModel viewModelAtIndexPath:indexPath]];
  return cell;
}

@end