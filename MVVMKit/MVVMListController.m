// 
// MVVMListController.m
// MVVMKit
//
// Created by Denys Kotelovych on 5/7/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <PromiseKit/Promise.h>

#import "MVVMListController.h"
#import "MVVMCell.h"

@interface MVVMListController ()

@property (nonatomic, strong) NSString *cellNibName;
@property (nonatomic, strong) NSString *cellIdentifier;

- (void)pvm_notifyFetchingStarted;
- (void)pvm_notifyFetchingEnded;
- (void)pvm_notifyFetchingFailed:(NSError *)error;

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

  [self pvm_notifyFetchingStarted];
  [self.viewModel fetchLocals]
    .then(^{
      [self reloadData];
      [self pvm_notifyFetchingEnded];
    })
    .then(^{
      [self pvm_notifyFetchingStarted];
      return [self.viewModel fetchRemotes];
    })
    .then(^{
      [self reloadData];
      [self pvm_notifyFetchingEnded];
    })
    .catch(^(NSError *error) {
      [self pvm_notifyFetchingFailed:error];
    });
}

- (void)reloadData {
  [self.tableView reloadData];
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

#pragma mark - Private Methods

- (void)pvm_notifyFetchingStarted {
  if ([self.delegate respondsToSelector:@selector(MVVMListControllerFetchingStarted:)]) {
    [self.delegate MVVMListControllerFetchingStarted:self];
  }
}

- (void)pvm_notifyFetchingEnded {
  if ([self.delegate respondsToSelector:@selector(MVVMListControllerFetchingEnded:)]) {
    [self.delegate MVVMListControllerFetchingEnded:self];
  }
}

- (void)pvm_notifyFetchingFailed:(NSError *)error {
  if ([self.delegate respondsToSelector:@selector(MVVMListControllerFetchingFailed:error:)]) {
    [self.delegate MVVMListControllerFetchingFailed:self error:error];
  }
}

@end