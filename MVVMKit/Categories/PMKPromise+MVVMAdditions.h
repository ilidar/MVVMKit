// 
// PMKPromise+MVVMAdditions.h
// MVVMKit
//
// Created by Denys Kotelovych on 7/6/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "Promise.h"

@interface PMKPromise (MVVMAdditions)

- (PMKPromise *(^)(id))then2;

@end