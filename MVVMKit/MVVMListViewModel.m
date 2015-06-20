// 
// MVVMListViewModel.m
// MVVMKit
//
// Created by Denys Kotelovych on 5/5/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PromiseKit/Promise+When.h>

#import "MVVMListViewModel.h"

@interface MVVMListViewModel ()

@property (nonatomic, assign) Class viewModelsClass;
@property (nonatomic, strong) id <MVVMListViewModelDataSource> dataSource;

@end

@implementation MVVMListViewModel

#pragma mark - Init Methods

- (instancetype)initWithDataSource:(id <MVVMListViewModelDataSource>)dataSource {
  return [self initWithDataSource:dataSource viewModelsClass:nil];
}

- (instancetype)initWithDataSource:(id <MVVMListViewModelDataSource>)dataSource
                   viewModelsClass:(Class)viewModelsClass {
  return [self initWithDataSource:dataSource viewModelsClass:viewModelsClass model:nil];
}

- (instancetype)initWithDataSource:(id <MVVMListViewModelDataSource>)dataSource
                   viewModelsClass:(Class)viewModelsClass
                             model:(MVVMModel *)model {
  self = [super initWithModel:model];
  if (!self) return nil;
  self.dataSource = dataSource;
  self.viewModelsClass = viewModelsClass;
  return self;
}

#pragma mark - MVVMListViewModelFetching Methods

- (PMKPromise *)fetchModelsRemotely {
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    fulfill(nil);
  }];
}

- (PMKPromise *)fetchModelsLocally {
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    fulfill(nil);
  }];
}

#pragma mark - MVVMListViewModelMerging Methods

- (PMKPromise *)mergeRemoteModels:(NSArray *)remoteModels withLocalModels:(NSArray *)localModels {
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    if ([remoteModels isKindOfClass:[NSArray class]]) {
      fulfill(remoteModels);
      return;
    }
    if ([localModels isKindOfClass:[NSArray class]]) {
      fulfill(localModels);
      return;
    }
    fulfill(nil);
  }];
}

#pragma mark - Public Methods

- (PMKPromise *)fetch {
  __typeof(self) __weak weakSelf = self;
  return [PMKPromise when:@[[self fetchModelsRemotely], [self fetchModelsLocally]]]
    .then(^(NSArray *results) {
      NSArray *remoteModels = results.count > 0 ? results[0] : nil;
      NSArray *localModels = results.count > 1 ? results[1] : nil;
      return [weakSelf mergeRemoteModels:remoteModels withLocalModels:localModels];
    })
    .then(^(NSArray *mergedModels) {
      return [weakSelf reloadWithModels:mergedModels];
    });
}

- (PMKPromise *)refresh {
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    fulfill([self.dataSource allModels]);
  }];
}

#pragma mark - MVVMListViewModelDataSource Methods

- (NSInteger)numberOfSections {
  return [self.dataSource numberOfSections];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
  return [self.dataSource numberOfRowsInSection:section];
}

- (NSIndexPath *)indexPathForModel:(MVVMModel *)model {
  return [self.dataSource indexPathForModel:model];
}

- (NSArray *)indexPathsForModels:(NSArray *)models {
  return [self.dataSource indexPathsForModels:models];
}

- (MVVMModel *)modelAtIndexPath:(NSIndexPath *)indexPath {
  return [self.dataSource modelAtIndexPath:indexPath];
}

- (NSArray *)modelsAtIndexPaths:(NSArray *)indexPaths {
  return [self.dataSource modelsAtIndexPaths:indexPaths];
}

- (PMKPromise *)reloadWithModels:(NSArray *)models {
  return [self.dataSource reloadWithModels:models];
}

- (NSArray *)allModels {
  return [self.dataSource allModels];
}

#pragma mark - MVVMListViewModelMapping Methods

- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath {
  id model = [self modelAtIndexPath:indexPath];
  Class viewModelClass = [self viewModelClassAtIndexPath:indexPath];
  if ([viewModelClass instancesRespondToSelector:@selector(initWithModel:)]) {
    return [(id) [viewModelClass alloc] initWithModel:model];
  }
  return nil;
}

- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)viewModel {
  return [self indexPathForModel:viewModel.model];
}

- (Class)viewModelClassAtIndexPath:(NSIndexPath *)indexPath {
  NSAssert(self.viewModelsClass != nil, @"self.viewModelsClass should be preset");
  return self.viewModelsClass;
}

@end
