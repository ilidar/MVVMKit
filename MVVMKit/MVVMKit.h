//
//  MVVMKit.h
//  MVVMKit
//
//  Created by Denys Kotelovych on 5/5/15.
//  Copyright (c) 2015 D. K. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MVVMKit.
FOUNDATION_EXPORT double MVVMKitVersionNumber;

//! Project version string for MVVMKit.
FOUNDATION_EXPORT const unsigned char MVVMKitVersionString[];

#ifdef __OBJC__
  #import "MVVMModel.h"
  #import "MVVMViewModel.h"
  #import "MVVMListViewModel.h"
  #import "MVVMDataSourceFetchedResults.h"
  #import "MVVMDataSourceInMemory.h"
  #import "MVVMController.h"
  #import "MVVMListController.h"
  #import "MVVMCell.h"
#endif