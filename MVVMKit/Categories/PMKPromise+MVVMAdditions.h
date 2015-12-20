// 
// PMKPromise+MVVMAdditions.h
// MVVMKit
//
// Created by Denys Kotelovych on 7/6/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <PromiseKit/PromiseKit.h>

@interface AnyPromise (MVVMAdditions)

- (AnyPromise *(^)(id))then2;
- (AnyPromise *(^)(id))then3;
- (AnyPromise *(^)(id))then4;

@end