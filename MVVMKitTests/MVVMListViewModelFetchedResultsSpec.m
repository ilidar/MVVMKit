//
//  MVVMListViewModelFetchedResultsSpec.m
//  MVVMKit
//
//  Created by Denys Kotelovych on 6/1/15.
//  Copyright 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <MagicalRecord/MagicalRecord.h>
#import <PromiseKit/PromiseKit.h>

#import "MVVMFeed.h"
#import "MVVMDataSourceFetchedResults.h"

SpecBegin(MVVMListViewModelFetchedResultsSpec)
  describe(@"MVVMFetchedListViewModel", ^{
    context(@"Fetching", ^{
      __block NSInteger numberOfModels;
      __block MVVMListViewModel *viewModel;

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

        id <MVVMListViewModelDataSource> dataSource = [[MVVMDataSourceFetchedResults alloc]
          initWithController:fetchedResultsController];

        viewModel = [[MVVMListViewModel alloc] initWithDataSource:dataSource];
      });

      it(@"Should have initialized", ^{
        expect([MVVMFeed MR_countOfEntities]).to.equal(numberOfModels);
      });

      it(@"Should have valid number of models", ^{
        __block NSInteger fetchedNumberOfModels = 0;
        [viewModel fetchLocals]
          .then(^{
            fetchedNumberOfModels = [viewModel numberOfRowsInSection:0];
          });
        expect(fetchedNumberOfModels).will.equal(numberOfModels);
      });

      afterAll(^{
        [MVVMFeed MR_truncateAll];
        [MagicalRecord cleanUp];
      });
    });
  });
SpecEnd
