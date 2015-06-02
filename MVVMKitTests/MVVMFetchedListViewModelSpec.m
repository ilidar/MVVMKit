//
//  MVVMFetchedListViewModelSpec.m
//  MVVMKit
//
//  Created by Denys Kotelovych on 6/1/15.
//  Copyright 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Kiwi/Kiwi.h>
#import <MagicalRecord/MagicalRecord.h>
#import <PromiseKit/PromiseKit.h>

#import "MVVMFeed.h"
#import "MVVMFetchedListViewModel.h"

SPEC_BEGIN(MVVMFetchedListViewModelSpec)
  describe(@"MVVMFetchedListViewModel", ^{
    context(@"Fetching", ^{
      __block NSInteger numberOfModels;
      __block MVVMFetchedListViewModel *viewModel;

      beforeAll(^{
        [MagicalRecord setDefaultModelFromClass:[self class]];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];

        srand((unsigned int) time(NULL));
        numberOfModels = 100 + rand() % 1000;
        for (int i = 0; i < numberOfModels; ++i) {
          MVVMFeed *feed = [MVVMFeed MR_createEntity];
          feed.feedID = @(i);
          feed.message = [NSString stringWithFormat:@"Feed message %d", i];
        }

        NSFetchedResultsController *fetchedResultsController =
          [MVVMFeed MR_fetchAllGroupedBy:nil withPredicate:nil sortedBy:@"feedID" ascending:YES];

        viewModel = [[MVVMFetchedListViewModel alloc]
          initWithFetchController:fetchedResultsController];
      });

      it(@"Should have initialized", ^{
        [[theValue([MVVMFeed MR_countOfEntities]) should] equal:@(numberOfModels)];
      });

      it(@"Should have valid number of models", ^{
        __block NSInteger fetchedNumberOfModels = 0;
        [viewModel fetch]
          .then(^{
            fetchedNumberOfModels = [viewModel numberOfRowsInSection:0];
          });
        [[theValue(fetchedNumberOfModels) shouldEventually] equal:theValue(numberOfModels)];
      });

      afterAll(^{
        [MVVMFeed MR_truncateAll];
        [MagicalRecord cleanUp];
      });
    });
  });
SPEC_END
