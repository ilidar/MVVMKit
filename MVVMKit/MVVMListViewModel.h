// 
// MVVMListViewModel.h
// MVVMKit
//
// Created by Denys Kotelovych on 5/5/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMViewModel.h"

@class PMKPromise;
@class MVVMListViewModel;

@protocol MVVMListViewModelDataSource <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSIndexPath *)indexPathForModel:(MVVMModel *)model;
- (NSArray *)indexPathsForModels:(NSArray *)models;
- (MVVMModel *)modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)modelsAtIndexPaths:(NSArray *)indexPaths;
- (PMKPromise *)reloadWithModels:(NSArray *)models;

@end

@protocol MVVMListViewModelFetching <NSObject>

- (PMKPromise *)fetchModelsRemotely;
- (PMKPromise *)fetchModelsLocally;

@end

@protocol MVVMListViewModelMerging <NSObject>

- (PMKPromise *)mergeRemoteModels:(NSArray *)remoteModels withLocalModels:(NSArray *)localModels;

@end

@protocol MVVMListViewModelMapping <NSObject>

- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)viewModel;
- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;
- (Class)viewModelClassAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MVVMListViewModel : MVVMViewModel
  <
  MVVMListViewModelFetching,
  MVVMListViewModelMerging,
  MVVMListViewModelDataSource,
  MVVMListViewModelMapping
  >

@property (nonatomic, assign) Class viewModelsClass;
@property (nonatomic, strong, readonly) id <MVVMListViewModelDataSource> dataSource;

- (instancetype)initWithDataSource:(id <MVVMListViewModelDataSource>)dataSource;
- (instancetype)initWithDataSource:(id <MVVMListViewModelDataSource>)dataSource
                   viewModelsClass:(Class)viewModelsClass;
- (instancetype)initWithDataSource:(id <MVVMListViewModelDataSource>)dataSource
                   viewModelsClass:(Class)viewModelsClass
                             model:(MVVMModel *)model;

- (PMKPromise *)fetch;

@end
