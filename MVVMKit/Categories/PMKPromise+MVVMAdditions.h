// 
// PMKPromise+MVVMAdditions.h
// MVVMKit
//
// Created by Denys Kotelovych on 7/6/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <PromiseKit/Promise.h>

@interface PMKPromise (MVVMAdditions)

- (PMKPromise *(^)(id))then2;
- (PMKPromise *(^)(id))then3;
- (PMKPromise *(^)(id))then4;

@end