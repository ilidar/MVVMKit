// 
// MVVMDataSourceFetchedResults.h
// MVVMKit
//
// Created by Denys Kotelovych on 6/2/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "MVVMListViewModel.h"

@interface MVVMDataSourceFetchedResults : NSObject <MVVMListViewModelDataSource>

@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

@end