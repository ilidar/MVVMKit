//
//  MVVMViewController.h
//  MVVMKit
//
//  Created by Denys Kotelovych on 5/5/15.
//  Copyright (c) 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVVMViewModel;

@interface MVVMViewController : UIViewController

@property (nonatomic, strong, readonly) MVVMViewModel *viewModel;

- (instancetype)initWithViewModel:(MVVMViewModel *)viewModel;

@end
