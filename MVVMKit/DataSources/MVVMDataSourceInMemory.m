// 
// MVVMDataSourceInMemory.m
// MVVMKit
//
// Created by Denys Kotelovych on 6/2/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <Functional/Functional.h>

#import "MVVMDataSourceInMemory.h"
#import "Promise.h"

@interface MVVMDataSourceInMemory ()

@property (nonatomic, strong) NSArray *sections;

@end

@implementation MVVMDataSourceInMemory

#pragma mark - Init Methods

- (instancetype)initWithModels:(NSArray *)models {
  return [self initWithSections:@[ models ]];
}

- (instancetype)initWithSections:(NSArray *)sections {
  self = [super init];
  if (!self) return nil;
  self.sections = sections;
  return self;
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

- (PMKPromise *)reloadWithModels:(NSArray *)models {
  __typeof(self) __weak weakSelf = self;
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    weakSelf.sections = models;
    fulfill(nil);
  }];
}

@end