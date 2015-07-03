//
//  MVVMListViewModelSpec.m
//  MVVMKit
//
//  Created by Denys Kotelovych on 7/3/15.
//  Copyright 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Kiwi/Kiwi.h>
#import <PromiseKit/PromiseKit.h>

#import "MVVMListViewModel.h"
#import "MVVMDataSourceInMemory.h"
#import "MVVMTestViewModel.h"
#import "MVVMTestListViewModel.h"

SPEC_BEGIN(MVVMListViewModelSpec)
  describe(@"MVVMListViewModel", ^{
    context(@"Fetching", ^{
      __block MVVMTestListViewModel *viewModel = nil;

      beforeEach(^{
        NSArray *models = @[ @1, @2, @3, @4 ];

        id <MVVMListViewModelDataSource> dataSource = [[MVVMDataSourceInMemory alloc]
          initWithModels:models];
        viewModel = [[MVVMTestListViewModel alloc]
          initWithDataSource:dataSource
          viewModelsClass:[MVVMTestViewModel class]];
      });

      it(@"should eventually exit local fetching block", ^{
        __block BOOL finished = NO;
        [viewModel fetchLocals]
          .finally(^{
            finished = YES;
          });
        [[expectFutureValue(theValue(finished)) shouldEventually] beYes];
      });

      it(@"should eventually exit remote fetching block", ^{
        __block BOOL finished = NO;
        [viewModel fetchRemotes]
          .finally(^{
            finished = YES;
          });
        [[expectFutureValue(theValue(finished)) shouldEventually] beYes];
      });

      it(@"should eventually exit local/remote fetching block", ^{
        __block BOOL finished = NO;
        [viewModel fetchLocals]
          .then(^{
            return [viewModel fetchRemotes];
          })
          .finally(^{
            finished = YES;
          });
        [[expectFutureValue(theValue(finished)) shouldEventually] beYes];
      });

      it(@"should eventually fail local fetching block", ^{
        __block BOOL finished = NO;
        [viewModel setFailableLocally:YES];
        [viewModel fetchLocals]
          .then(^{
            return [viewModel fetchRemotes];
          })
          .catch(^(NSError *error) {
            finished = YES;
          });
        [[expectFutureValue(theValue(finished)) shouldEventually] beYes];
      });

      it(@"should eventually fail remote fetching block", ^{
        __block BOOL finished = NO;
        [viewModel setFailableRemotely:YES];
        [viewModel fetchLocals]
          .then(^{
            return [viewModel fetchRemotes];
          })
          .catch(^(NSError *error) {
            finished = YES;
          });
        [[expectFutureValue(theValue(finished)) shouldEventually] beYes];
      });
    });
  });
SPEC_END
