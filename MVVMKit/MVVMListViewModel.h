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
- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)model;
- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;
- (Class)viewModelClassAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MVVMListViewModelFetching <NSObject>

- (PMKPromise *)fetchModelsRemotely;
- (PMKPromise *)fetchModelsLocally;

@end

@protocol MVVMListViewModelMerging <NSObject>

- (PMKPromise *)mergeRemoteModels:(NSArray *)remoteModels withLocalModels:(NSArray *)localModels;

@end

@protocol MVVMListViewModelSectioning <NSObject>

- (NSArray *)sectionsForModels:(NSArray *)objects;

@end

@protocol MVVMListViewModelMapping <NSObject>

- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)viewModel;
- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MVVMListViewModel : MVVMViewModel
  <
  MVVMListViewModelFetching,
  MVVMListViewModelSectioning,
  MVVMListViewModelDataSource,
  MVVMListViewModelMapping,
  MVVMListViewModelMerging
  >

@property (nonatomic, assign) Class viewModelsClass;

- (instancetype)initWithModels:(NSArray *)models;

- (PMKPromise *)fetch;
- (PMKPromise *)reload;
- (PMKPromise *)reloadWithModels:(NSArray *)models;

@end
