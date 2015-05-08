//
// Created by Denys Kotelovych on 5/7/15.
// Copyright (c) 2015 D. K. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MVVMViewModel;

@protocol MVVMCell <NSObject>

// FIXME: think about type substitution
- (void)reloadWithViewModel:(id)viewModel;

@end