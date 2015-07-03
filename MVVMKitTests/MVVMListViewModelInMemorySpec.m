//
//  MVVMListViewModelInMemorySpec.m
//  MVVMKit
//
//  Created by Denys Kotelovych on 5/29/15.
//  Copyright 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PromiseKit/PromiseKit.h>
#import <Kiwi/Kiwi.h>

#import "MVVMDataSourceInMemory.h"
#import "MVVMTestViewModel.h"

SPEC_BEGIN(MVVMListViewModelInMemorySpec)
  describe(@"MVVMListViewModelInMemory", ^{
    context(@"Validating", ^{
      NSArray *models = @[ @1, @2, @3, @4 ];

      id <MVVMListViewModelDataSource> dataSource = [[MVVMDataSourceInMemory alloc] initWithModels:models];
      MVVMListViewModel *listViewModel = [[MVVMListViewModel alloc]
        initWithDataSource:dataSource
        viewModelsClass:[MVVMTestViewModel class]];

      it(@"Should create proper view model instances", ^{
        id viewModel = [listViewModel viewModelAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [[viewModel should] beKindOfClass:[MVVMTestViewModel class]];
      });

      it(@"Should return proper index paths", ^{
        for (NSUInteger i = 0; i < models.count; ++i) {
          id model = models[i];
          NSIndexPath *indexPath = [listViewModel indexPathForModel:model];
          [[indexPath should] equal:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        NSArray *indexPaths = [listViewModel indexPathsForModels:models];
        [[theValue(indexPaths.count) should] equal:theValue(models.count)];
        for (NSUInteger i = 0; i < indexPaths.count; ++i) {
          [[indexPaths[i] should] equal:[NSIndexPath indexPathForRow:i inSection:0]];
        }
      });
    });
  });
SPEC_END
