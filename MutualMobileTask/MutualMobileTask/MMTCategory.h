//
//  MMTCategory.h
//  MutualMobileTask
//
//  Created by Madhu on 24/03/16.
//  Copyright © 2016 MutualMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTCategory : NSObject

@property (nonatomic, retain) NSString *categoryDate;
@property (nonatomic, retain) NSString *categoryTitle;
@property (nonatomic, retain) NSArray *categoryDescription;

+ (BOOL)isEmpty:(id)aValue;
+ (NSArray *)loadCategorysFromServerData:(NSArray *)data;

@end
