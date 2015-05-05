//
//  MVVMViewModel.h
//  MVVMKit
//
//  Created by Denys Kotelovych on 5/5/15.
//  Copyright (c) 2015 D. K. All rights reserved.
//

#import "MVVMModel.h"

@interface MVVMViewModel : NSObject

@property (nonatomic, strong, readonly) MVVMModel *model;

- (instancetype)initWithModel:(MVVMModel *)model;

@end
