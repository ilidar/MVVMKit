// 
// MVVMFetchedListViewModel.m
// MVVMKit
//
// Created by Denys Kotelovych on 6/1/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <PromiseKit/PromiseKit.h>
#import <Functional/Functional.h>

#import "MVVMFetchedListViewModel.h"

static inline NSString *MVVMFetchedListViewModelGetCacheName(MVVMFetchedListViewModel *viewModel) {
  return [NSStringFromClass(viewModel.class) stringByAppendingString:@"_Cache"];
}

@interface MVVMFetchedListViewModel ()

@property (nonatomic, strong) NSFetchedResultsController *fetchController;

@end

@implementation MVVMFetchedListViewModel

#pragma mark - Init Methods

- (instancetype)initWithFetchRequest:(NSFetchRequest *)fetchRequest context:(NSManagedObjectContext *)context {
  return [self initWithFetchController:[[NSFetchedResultsController alloc]
    initWithFetchRequest:fetchRequest
    managedObjectContext:context
    sectionNameKeyPath:nil
    cacheName:MVVMFetchedListViewModelGetCacheName(self)]];
}

- (instancetype)initWithFetchController:(NSFetchedResultsController *)fetchController {
  self = [super init];
  if (!self) return nil;
  self.fetchController = fetchController;
  return self;
}

#pragma mark - Overridden Methods

- (PMKPromise *)fetchModelsLocally {
  __typeof(self) __weak weakSelf = self;
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    NSError *error = nil;
    if ([weakSelf.fetchController performFetch:&error]) {
      fulfill(weakSelf.fetchController.fetchedObjects);
    } else {
      reject(error);
    }
  }];
}

- (NSArray *)sectionsForModels:(NSArray *)objects {
  return [self.fetchController.sections
    map:^id(id <NSFetchedResultsSectionInfo> info) {
      return info.objects;
    }];
}

@end