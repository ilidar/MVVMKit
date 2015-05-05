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
- (NSIndexPath *)indexPathForModel:(id)object;
- (NSArray *)indexPathsForModels:(NSArray *)objects;
- (id)modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)modelsAtIndexPaths:(NSArray *)indexPaths;
- (NSIndexPath *)indexPathForViewModel:(MVVMViewModel *)object;
- (MVVMViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteModelAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MVVMListViewModelSectioning <NSObject>

- (NSArray *)sectionsForModels:(NSArray *)objects;
- (NSString *)identifierForSection:(NSInteger)section;

@end

typedef void (^MVVMListViewModelResult)();

@interface MVVMListViewModel : MVVMViewModel
  <
  MVVMListViewModelFetching,
  MVVMListViewModelSectioning,
  MVVMListViewModelDataSource
  >

- (instancetype)initWithModels:(NSArray *)models;

- (void)fetch:(MVVMListViewModelResult)result;
- (void)reload;
- (void)reloadWithModels:(NSArray *)models;

@end