//
//  MVVMController.m
//  MVVMKit
//
//  Created by Denys Kotelovych on 5/5/15.
//  Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMController.h"

@interface MVVMController ()

@property (nonatomic, strong) MVVMViewModel *viewModel;

@end

@implementation MVVMController

#pragma mark - Init Methods

- (instancetype)initWithViewModel:(MVVMViewModel *)viewModel {
  self = [super init];
  if (!self) return nil;
  self.viewModel = viewModel;
  return self;
}

@end
