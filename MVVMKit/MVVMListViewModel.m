// 
// MVVMListViewModel.m
// MVVMKit
//
// Created by Denys Kotelovych on 5/5/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMListViewModel.h"

@interface MVVMListViewModel ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSMutableArray *mutableModels;

@end


@implementation MVVMListViewModel

#pragma mark - Init Methods

- (instancetype)initWithModel:(MVVMModel *)model {
  return [self initWithModels:@[ model ]];
}

- (instancetype)initWithModels:(NSArray *)models {
  self = [super init];
  if (!self) return nil;
  [self reloadWithModels:models];
  return self;
}

#pragma mark - Overridden Methods

- (void)fetchModels:(MVVMListViewModelFetchingResult)result {
  NSAssert(NO, @"Method should be overridden by subclasses");
}

#pragma mark - Public Methods

- (void)fetch:(MVVMListViewModelResult)result {
  __weak __typeof(self) weakSelf = self;
  [self fetchModels:^(NSArray *objects) {
    [weakSelf setMutableModels:objects.mutableCopy];
    [weakSelf reload];
    if (result) {
      result();
    }
  }];
}

- (void)reload {
  [self reloadWithModels:self.mutableModels];
}

- (void)reloadWithModels:(NSArray *)models {
  self.mutableModels = models.mutableCopy;
  self.sections = [self sectionsForModels:models];
}

#pragma mark - MVVMListViewModelSectioning Methods

- (NSArray *)sectionsForModels:(NSArray *)objects {
  return nil;
}

- (NSString *)identifierForSection:(NSInteger)section {
  return nil;
}

#pragma mark - MVVMListViewModelDataSource Methods

- (NSInteger)numberOfSections {
  return 0;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
  return 0;
}

- (NSIndexPath *)indexPathForModel:(id)object {
  return nil;
}

- (NSArray *)indexPathsForModels:(NSArray *)objects {
  return nil;
}

- (id)modelAtIndexPath:(NSIndexPath *)indexPath {
  return nil;
}

- (NSArray *)modelsAtIndexPaths:(NSArray *)indexPaths {
  return nil;
}

- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)object {
  return nil;
}

- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath {
  return nil;
}

- (void)deleteModelAtIndexPath:(NSIndexPath *)indexPath {
}

@end