//
//  MVVMFeed.h
//  MVVMKit
//
//  Created by Denys Kotelovych on 6/2/15.
//  Copyright (c) 2015 D. K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MVVMFeed : NSManagedObject

@property (nonatomic, retain) NSNumber * feedID;
@property (nonatomic, retain) NSString * message;

@end
