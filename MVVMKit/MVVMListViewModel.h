// 
// MVVMListViewModel.h
// MVVMKit
//
// Created by Denys Kotelovych on 5/5/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <PromiseKit/Promise.h>

#import "MVVMViewModel.h"

@protocol MVVMListViewModelFetching <NSObject>

- (PMKPromise *)fetchModels;

@end

@protocol MVVMListViewModelDataSource <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSIndexPath *)indexPathForModel:(MVVMModel *)model;
- (NSArray *)indexPathsForModels:(NSArray *)models;
- (MVVMModel *)modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)modelsAtIndexPaths:(NSArray *)indexPaths;
- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)model;
- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MVVMListViewModelSectioning <NSObject>

- (NSArray *)sectionsForModels:(NSArray *)objects;

@end

@protocol MVVMListViewModelMapping <NSObject>

- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)viewModel;
- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef void (^MVVMListViewModelResult)();

@interface MVVMListViewModel : MVVMViewModel
  <
  MVVMListViewModelFetching,
  MVVMListViewModelSectioning,
  MVVMListViewModelDataSource,
  MVVMListViewModelMapping
  >

- (instancetype)initWithModels:(NSArray *)models;

- (PMKPromise *)fetch;
- (void)reload;
- (void)reloadWithModels:(NSArray *)models;

@end