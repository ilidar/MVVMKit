// 
// MVVMDataSourceFetchedResults.m
// MVVMKit
//
// Created by Denys Kotelovych on 6/2/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <Functional/Functional.h>
#import <PromiseKit/Promise.h>

#import "MVVMDataSourceFetchedResults.h"

@interface MVVMDataSourceFetchedResults ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation MVVMDataSourceFetchedResults

#pragma mark - Init Methods

- (instancetype)initWithController:(NSFetchedResultsController *)fetchedResultsController {
  self = [super init];
  if (!self) return nil;
  self.fetchedResultsController = fetchedResultsController;
  return self;
}

#pragma mark - MVVMListViewModelDataSource Methods

- (NSInteger)numberOfSections {
  return self.fetchedResultsController.sections.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
  id <NSFetchedResultsSectionInfo> sectionInfo =
    self.fetchedResultsController.sections[(NSUInteger) section];
  return sectionInfo.numberOfObjects;
}

- (NSIndexPath *)indexPathForModel:(MVVMModel *)model {
  return [self.fetchedResultsController indexPathForObject:model];
}

- (NSArray *)indexPathsForModels:(NSArray *)models {
  __typeof(self) __weak weakSelf = self;
  return [models map:^id(id model) {
    return [weakSelf indexPathForModel:model];
  }];
}

- (MVVMModel *)modelAtIndexPath:(NSIndexPath *)indexPath {
  return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSArray *)modelsAtIndexPaths:(NSArray *)indexPaths {
  __typeof(self) __weak weakSelf = self;
  return [indexPaths map:^id(NSIndexPath *indexPath) {
    return [weakSelf modelAtIndexPath:indexPath];
  }];
}

- (PMKPromise *)reloadWithModels:(NSArray *)models {
  __typeof(self) __weak weakSelf = self;
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    NSError *error = nil;
    if ([weakSelf.fetchedResultsController performFetch:&error]) {
      fulfill(nil);
    } else {
      reject(error);
    }
  }];
}

- (NSArray *)allModels {
  return self.fetchedResultsController.fetchedObjects;
}

@end