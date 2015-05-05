//
//  MVVMViewController.m
//  MVVMKit
//
//  Created by Denys Kotelovych on 5/5/15.
//  Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMViewController.h"

@interface MVVMViewController ()

@property (nonatomic, strong) MVVMViewModel *viewModel;

@end

@implementation MVVMViewController

#pragma mark - Init Methods

- (instancetype)initWithViewModel:(MVVMViewModel *)viewModel {
  self = [super init];
  if (!self) return nil;
  self.viewModel = viewModel;
  return self;
}

@end
