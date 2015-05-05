// 
// MVVMListViewModel.h
// MVVMKit
//
// Created by Denys Kotelovych on 5/5/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMViewModel.h"

typedef void (^MVVMListViewModelFetchingResult)(NSArray *models);

@protocol MVVMListViewModelFetching <NSObject>

- (void)fetchModels:(MVVMListViewModelFetchingResult)result;

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

- (void)fetch:(MVVMListViewModelResult)result;
- (void)reload;
- (void)reloadWithModels:(NSArray *)models;

@end