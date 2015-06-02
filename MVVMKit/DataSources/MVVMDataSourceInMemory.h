// 
// MVVMDataSourceInMemory.h
// MVVMKit
//
// Created by Denys Kotelovych on 6/2/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMListViewModel.h"

@interface MVVMDataSourceInMemory : NSObject <MVVMListViewModelDataSource>

- (instancetype)initWithModels:(NSArray *)models;
- (instancetype)initWithSections:(NSArray *)sections;

@end