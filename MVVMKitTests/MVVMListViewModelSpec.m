//
//  MVVMListViewModelSpec.m
//  MVVMKit
//
//  Created by Denys Kotelovych on 5/29/15.
//  Copyright 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PromiseKit/PromiseKit.h>
#import <Kiwi/Kiwi.h>

#import "MVVMListViewModel.h"

@interface MVVMViewModelTest : MVVMViewModel
@end

@implementation MVVMViewModelTest
@end


SPEC_BEGIN(MVVMListViewModelSpec)
  describe(@"MVVMListViewModel", ^{
    context(@"Fetching", ^{
      it(@"Should create valid view model instances", ^{
        NSArray *models = @[ @1, @2, @3, @4 ];
        MVVMListViewModel *listViewModel = [[MVVMListViewModel alloc] initWithModels:models];
        listViewModel.viewModelsClass = [MVVMViewModelTest class];
        id viewModel = [listViewModel viewModelAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [[viewModel should] beKindOfClass:[MVVMViewModelTest class]];
      });

      it(@"Should eventually exit fetching block", ^{
        __block BOOL finished = NO;
        MVVMListViewModel *viewModel = [[MVVMListViewModel alloc] init];
        [viewModel fetch]
          .finally(^{
            finished = YES;
          });
        [[expectFutureValue(theValue(finished)) shouldEventually] beYes];
      });
    });
  });
SPEC_END
