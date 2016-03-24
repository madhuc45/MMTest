//
//  MMTCategory.m
//  MutualMobileTask
//
//  Created by Madhu on 24/03/16.
//  Copyright © 2016 MutualMobile. All rights reserved.
//

#import "MMTCategory.h"
#import "MMTConstants.h"

@implementation MMTCategory

+ (NSArray *)loadCategorysFromServerData:(NSArray *)data
{
    NSMutableArray *categorys = [NSMutableArray arrayWithCapacity:data.count];
    for (NSDictionary *item in data) {
        
        MMTCategory *category = [[MMTCategory alloc] init];
        
        if (NO == [self isEmpty:[item objectForKey:kMMTCategoryDateKey]]) {
            category.categoryDate = item[kMMTCategoryDateKey];
        }
        if (NO == [self isEmpty:[[item objectForKey:kMMTCategoryDetailsKey] objectForKey:kMMTCategoryTitleKey]]) {
            category.categoryTitle = [[item objectForKey:kMMTCategoryDetailsKey] objectForKey:kMMTCategoryTitleKey];
        }
        if (NO == [self isEmpty:[[item objectForKey:kMMTCategoryDetailsKey] objectForKey:kMMTCategorDescriptionKey]]) {
            category.categoryDescription = [[item objectForKey:kMMTCategoryDetailsKey] objectForKey:kMMTCategorDescriptionKey];
        }
        [categorys addObject:category];
    }
    return categorys;
}

+ (BOOL)isEmpty:(id)aValue
{
    if ([aValue isKindOfClass:[NSNull class]] || !aValue) {
        return YES;
    }
    return NO;
}


@end
