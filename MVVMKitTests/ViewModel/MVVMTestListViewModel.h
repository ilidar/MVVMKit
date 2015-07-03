// 
// MVVMTestListViewModel.h
// MVVMKit
//
// Created by Denys Kotelovych on 7/3/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMListViewModel.h"

@interface MVVMTestListViewModel : MVVMListViewModel

@property (nonatomic, assign, getter=isFailableRemotely) BOOL failableRemotely;
@property (nonatomic, assign, getter=isFailableLocally) BOOL failableLocally;

@end