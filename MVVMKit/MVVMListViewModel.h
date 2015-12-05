// 
// MVVMListViewModel.h
// MVVMKit
//
// Created by Denys Kotelovych on 5/5/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMViewModel.h"

@class AnyPromise;
@class MVVMListViewModel;

@protocol MVVMListViewModelDataSource <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSIndexPath *)indexPathForModel:(MVVMModel *)model;
- (NSArray *)indexPathsForModels:(NSArray *)models;
- (MVVMModel *)modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)modelsAtIndexPaths:(NSArray *)indexPaths;
- (NSArray *)allModels;
- (AnyPromise *)reloadWithModels:(NSArray *)models;

@end

@protocol MVVMListViewModelFetching <NSObject>

- (AnyPromise *)fetchModelsRemotely;
- (AnyPromise *)fetchModelsLocally;

@end

@protocol MVVMListViewModelMerging <NSObject>

- (AnyPromise *)mergeRemoteModels:(NSArray *)remoteModels withLocalModels:(NSArray *)localModels;

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

@property (nonatomic, assign, readonly) Class viewModelsClass;
@property (nonatomic, strong, readonly) id <MVVMListViewModelDataSource> dataSource;

- (instancetype)initWithDataSource:(id <MVVMListViewModelDataSource>)dataSource;
- (instancetype)initWithDataSource:(id <MVVMListViewModelDataSource>)dataSource
                   viewModelsClass:(Class)viewModelsClass;
- (instancetype)initWithDataSource:(id <MVVMListViewModelDataSource>)dataSource
                   viewModelsClass:(Class)viewModelsClass
                             model:(MVVMModel *)model;

- (AnyPromise *)fetchLocals;
- (AnyPromise *)fetchRemotes;
- (AnyPromise *)refresh;

@end
