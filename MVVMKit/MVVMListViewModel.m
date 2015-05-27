// 
// MVVMListViewModel.m
// MVVMKit
//
// Created by Denys Kotelovych on 5/5/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MVVMListViewModel.h"

@interface MVVMListViewModel ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSMutableArray *mutableModels;

@end


@implementation MVVMListViewModel

#pragma mark - Init Methods

- (instancetype)initWithModels:(NSArray *)models {
  self = [super init];
  if (!self) return nil;
  [self reloadWithModels:models];
  return self;
}

#pragma mark - MVVMListViewModelFetching Methods

- (PMKPromise *)fetchModelsRemotely {
  return [PMKPromise
    new:^(PMKFulfiller fulfill, PMKRejecter reject) {
      fulfill(nil);
    }];
}

- (PMKPromise *)fetchModelsLocally {
  return nil;
}

#pragma mark - MVVMListViewModelMapping Methods

- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath {
  NSAssert(NO, @"Method should be overridden by subclasses");
  return nil;
}

- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)viewModel {
  return [self indexPathForModel:viewModel.model];
}

#pragma mark - MVVMListViewModelMerging Methods

- (PMKPromise *)mergeRemoteModels:(NSArray *)remoteModels withLocalModels:(NSArray *)localModels {
  return nil;
}

#pragma mark - Public Methods

- (PMKPromise *)fetch {
//  __weak __typeof(self) weakSelf = self;
//  return [self fetchModels]
//    .then(^(NSArray *models) {
//      [weakSelf reloadWithModels:models];
//    });
  return nil;
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
  NSMutableArray *result = [NSMutableArray new];
  for (MVVMModel *model in models) {
    NSIndexPath *indexPath = [self indexPathForModel:model];
    if (indexPath) {
      [result addObject:indexPath];
    } else {
      [result addObject:[NSNull null]];
    }
  }
  return result;
}

- (MVVMModel *)modelAtIndexPath:(NSIndexPath *)indexPath {
  return self.sections[(NSUInteger) indexPath.section][(NSUInteger) indexPath.row];
}

- (NSArray *)modelsAtIndexPaths:(NSArray *)indexPaths {
  NSMutableArray *result = [NSMutableArray new];
  for (NSIndexPath *indexPath in indexPaths) {
    MVVMModel *model = [self modelAtIndexPath:indexPath];
    if (model) {
      [result addObject:model];
    } else {
      [result addObject:[NSNull null]];
    }
  }
  return result;
}

@end
