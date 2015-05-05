//
//  MVVMViewModel.m
//  MVVMKit
//
//  Created by Denys Kotelovych on 5/5/15.
//  Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMViewModel.h"

@interface MVVMViewModel ()

@property (nonatomic, strong) MVVMModel *model;

@end

@implementation MVVMViewModel

#pragma mark - Init Methods

- (instancetype)initWithModel:(MVVMModel *)model {
  self = [super init];
  if (!self) return nil;
  self.model = model;
  return self;
}

#pragma mark - Overridden Methods

- (BOOL)isEqual:(MVVMViewModel *)other {
  if (other == self) {
    return YES;
  }
  if (!other || ![[other class] isEqual:[self class]]) {
    return NO;
  }
  return [self.model isEqual:other.model];
}

- (NSUInteger)hash {
  return [self.model hash];
}

@end