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

- (PMKPromise *(^)(id))then3 {
  return ^(id block) {
    return self.thenOn(dispatch_get_main_queue(), ^(NSArray *results) {
      id x = results.count > 0 ? results[0] : nil;
      id y = results.count > 1 ? results[1] : nil;
      id z = results.count > 2 ? results[2] : nil;
      return ((PMKPromise *(^)(id, id, id)) block )(x, y, z);
    });
  };
}

- (PMKPromise *(^)(id))then4 {
  return ^(id block) {
    return self.thenOn(dispatch_get_main_queue(), ^(NSArray *results) {
      id x = results.count > 0 ? results[0] : nil;
      id y = results.count > 1 ? results[1] : nil;
      id z = results.count > 2 ? results[2] : nil;
      id k = results.count > 3 ? results[3] : nil;
      return ((PMKPromise *(^)(id, id, id, id)) block )(x, y, z, k);
    });
  };
}

@end