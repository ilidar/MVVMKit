// 
// MVVMFetchedListViewModel.h
// MVVMKit
//
// Created by Denys Kotelovych on 6/1/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "MVVMListViewModel.h"

@class MVVMFetchedListViewModel;

@protocol MVVMFetchedListViewModelDelegate <NSObject>

 @optional
- (void)fetchedListViewModelDidBeginUpdates:(MVVMFetchedListViewModel *)viewModel;
- (void)fetchedListViewModel:(MVVMFetchedListViewModel *)viewModel didInsertModelsAtIndexPaths:(NSArray *)indexPaths;
- (void)fetchedListViewModel:(MVVMFetchedListViewModel *)viewModel didDeleteModelsAtIndexPaths:(NSArray *)indexPaths;
- (void)fetchedListViewModel:(MVVMFetchedListViewModel *)viewModel didUpdateModelsAtIndexPaths:(NSArray *)indexPaths;
- (void)fetchedListViewModel:(MVVMFetchedListViewModel *)viewModel didMoveModelsAtIndexPaths:(NSArray *)oldIndexPaths toIndexPaths:(NSArray *)newIndexPaths;
- (void)fetchedListViewModelDidEndUpdates:(MVVMFetchedListViewModel *)viewModel;

@end

@interface MVVMFetchedListViewModel : MVVMListViewModel

@property (nonatomic, weak) id <MVVMFetchedListViewModelDelegate> delegate;

- (instancetype)initWithFetchRequest:(NSFetchRequest *)fetchRequest context:(NSManagedObjectContext *)context;
- (instancetype)initWithFetchController:(NSFetchedResultsController *)fetchController;

@end