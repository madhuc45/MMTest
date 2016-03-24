//
//  ViewController.h
//  MutualMobileTask
//
//  Created by Madhu on 24/03/16.
//  Copyright (c) 2016 MutualMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMTRootViewController : UIViewController < UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *dateCollectionView;
@property (strong, nonatomic) IBOutlet UIView *detailsView;

@property (strong, nonatomic) IBOutlet UILabel *titleDataLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionDataLabel;

@end

