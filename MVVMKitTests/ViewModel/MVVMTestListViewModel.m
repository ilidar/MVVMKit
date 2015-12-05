// 
// MVVMTestListViewModel.m
// MVVMKit
//
// Created by Denys Kotelovych on 7/3/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <PromiseKit/PromiseKit.h>

#import "MVVMTestListViewModel.h"

static NSString *const sMVVMTestListViewModelErrorDomain = @"MVVMTestListViewModelErrorDomain";

static inline void sDispatch(void(^block)()) {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) ( 0.2f * NSEC_PER_SEC )), dispatch_get_main_queue(), block);
}

@implementation MVVMTestListViewModel

#pragma mark - Overridden Methods

- (AnyPromise *)fetchModelsLocally {
  __typeof(self) __weak weakSelf = self;
  return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
    if ([weakSelf isFailableLocally]) {
      resolve([NSError errorWithDomain:sMVVMTestListViewModelErrorDomain code:0 userInfo:nil]);
      return;
    }
    sDispatch(^{
      resolve(@[ @6, @5, @4, @3, @2, @1 ]);
    });
  }];
}

- (AnyPromise *)fetchModelsRemotely {
  __typeof(self) __weak weakSelf = self;
  return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
    if ([weakSelf isFailableRemotely]) {
      resolve([NSError errorWithDomain:sMVVMTestListViewModelErrorDomain code:0 userInfo:nil]);
      return;
    }
    sDispatch(^{
      resolve(@[ @2, @3, @4, @5 ]);
    });
  }];
}

@end