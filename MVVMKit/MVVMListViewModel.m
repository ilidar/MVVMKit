// 
// MVVMListViewModel.m
// MVVMKit
//
// Created by Denys Kotelovych on 5/5/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PromiseKit/Promise.h>
#import <Functional/Functional.h>

#import "MVVMListViewModel.h"
#import "Promise+When.h"

@interface MVVMListViewModel ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSMutableArray *mutableModels;

@end

@implementation MVVMListViewModel

#pragma mark - Static Methods

+ (Class)MVVMViewModelGenerationClass {
  NSAssert(NO, @"Method should be overridden by subclasses");
  return nil;
}

#pragma mark - Init Methods

- (instancetype)initWithModels:(NSArray *)models {
  self = [super init];
  if (!self) return nil;
  [self reloadWithModels:models];
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

#pragma mark - MVVMListViewModelMerging Methods

- (PMKPromise *)mergeRemoteModels:(NSArray *)remoteModels withLocalModels:(NSArray *)localModels {
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    fulfill(remoteModels);
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

- (PMKPromise *)reload {
  return [self reloadWithModels:self.mutableModels];
}

- (PMKPromise *)reloadWithModels:(NSArray *)models {
  __typeof(self) __weak weakSelf = self;
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    weakSelf.mutableModels = models.mutableCopy;
    weakSelf.sections = [weakSelf sectionsForModels:models];
    fulfill(nil);
  }];
}

#pragma mark - MVVMListViewModelSectioning Methods

- (NSArray *)sectionsForModels:(NSArray *)models {
  return @[ models ];
}

#pragma mark - MVVMListViewModelDataSource Methods

- (NSInteger)numberOfSections {
  return self.sections.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
  return [self.sections[(NSUInteger) section] count];
}

- (NSIndexPath *)indexPathForModel:(MVVMModel *)model {
  __block NSIndexPath *indexPath = nil;
  [self.sections enumerateObjectsUsingBlock:^(NSArray *section, NSUInteger sectionIndex, BOOL *stop) {
    NSUInteger rowIndex = [section indexOfObject:model];
    if (rowIndex != NSNotFound) {
      indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
      *stop = YES;
    }
  }];
  return indexPath;
}

- (NSArray *)indexPathsForModels:(NSArray *)models {
  return [models map:^id(id model) {
    return [self indexPathForModel:model] ?: [NSNull null];
  }];
}

- (MVVMModel *)modelAtIndexPath:(NSIndexPath *)indexPath {
  return self.sections[(NSUInteger) indexPath.section][(NSUInteger) indexPath.row];
}

- (NSArray *)modelsAtIndexPaths:(NSArray *)indexPaths {
  return [indexPaths map:^id(NSIndexPath *indexPath) {
    return [self modelAtIndexPath:indexPath] ?: [NSNull null];
  }];
}

@end
