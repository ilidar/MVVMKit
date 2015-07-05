// 
// PMKPromise+MVVMAdditions.m
// MVVMKit
//
// Created by Denys Kotelovych on 7/6/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "PMKPromise+MVVMAdditions.h"

@implementation PMKPromise (MVVMAdditions)

- (PMKPromise *(^)(id))then2 {
  return ^(id block) {
    return self.thenOn(dispatch_get_main_queue(), ^(NSArray *results) {
      id x = results.count > 0 ? results[0] : nil;
      id y = results.count > 1 ? results[1] : nil;
      return ((PMKPromise *(^)(id, id)) block )(x, y);
    });
  };
}

@end