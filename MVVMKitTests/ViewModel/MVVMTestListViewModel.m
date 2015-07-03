// 
// MVVMTestListViewModel.m
// MVVMKit
//
// Created by Denys Kotelovych on 7/3/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <PromiseKit/PromiseKit.h>

#import "MVVMTestListViewModel.h"

static inline void sDispatch(void(^block)()) {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) ( 0.2f * NSEC_PER_SEC )), dispatch_get_main_queue(), block);
}

@implementation MVVMTestListViewModel

#pragma mark - Overridden Methods

- (PMKPromise *)fetchModelsLocally {
  __typeof(self) __weak weakSelf = self;
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    if ([weakSelf isFailableLocally]) {
      reject(nil);
      return;
    }
    sDispatch(^{
      fulfill(@[ @6, @5, @4, @3, @2, @1 ]);
    });
  }];
}

- (PMKPromise *)fetchModelsRemotely {
  __typeof(self) __weak weakSelf = self;
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    if ([weakSelf isFailableRemotely]) {
      reject(nil);
      return;
    }
    sDispatch(^{
      fulfill(@[ @2, @3, @4, @5 ]);
    });
  }];
}

@end