//
//  ViewController.m
//  MutualMobileTask
//
//  Created by Madhu on 24/03/16.
//  Copyright (c) 2016 MutualMobile. All rights reserved.
//

#import "MMTRootViewController.h"
#import "MMTCollectionViewCell.h"
#import "MMTCategory.h"
#import "MMTConstants.h"

@interface MMTRootViewController ()
{
    NSMutableArray *categoryArray;
    NSIndexPath *selectedIndexPath;
}
@end

@implementation MMTRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    categoryArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self.navigationItem setTitle:NSLocalizedString(@"MMT Data", nil)];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getServerData];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDetailsView:)];
    [tapGesture setDelegate:self];
    [_detailsView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return categoryArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UINib *nib = [UINib nibWithNibName:@"MMTCollectionViewCell" bundle:nil];
    [_dateCollectionView registerNib:nib forCellWithReuseIdentifier:@"MMTCollectionViewCellIdentifier"];
    

    MMTCollectionViewCell *cell = (MMTCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MMTCollectionViewCellIdentifier" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor lightTextColor];

    MMTCategory *category = [categoryArray objectAtIndex:indexPath.row];
    [cell.dateLabel setText:category.categoryDate];
    cell.layer.cornerRadius = 5.0;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MMTCollectionViewCell *cell = (MMTCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor lightTextColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MMTCollectionViewCell *cell = (MMTCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];

    selectedIndexPath = indexPath;
    MMTCategory *category = [categoryArray objectAtIndex:indexPath.row];
    [_titleDataLabel setText:category.categoryTitle];
    NSArray *categoryDescription = category.categoryDescription;
    NSMutableString *description = [[NSMutableString alloc] initWithString:[categoryDescription objectAtIndex:0]];
    for (int i = 1; i < categoryDescription.count; i++) {
        [description appendString:@"\n"];
        [description appendString:[categoryDescription objectAtIndex:i]];
    }
    [_descriptionDataLabel setText:description];
    [_detailsView setHidden:NO];
}

#pragma mark - Web Service Method
- (void)getServerData
{
    NSString *stringForURL = @"https://www.dropbox.com/s/g4ic9l6kq0kvyyp/screening.json?raw=1";
    NSURL *url = [NSURL URLWithString:stringForURL];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *_response, NSData *_data, NSError *_error) {
                               NSError *error;
                               id serverData = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:&error];
                               if (serverData != nil) {
                                   if ([serverData isKindOfClass:[NSArray class]]) {
                                       if (categoryArray == nil) {
                                           categoryArray = [[NSMutableArray alloc] init];
                                       }
                                       [categoryArray addObjectsFromArray:[MMTCategory loadCategorysFromServerData:serverData]];
                                   } else {
                                       [categoryArray addObjectsFromArray:[MMTCategory loadCategorysFromServerData:[serverData objectForKey:@"dates"]]];
                                   }
                               } 
                               [_dateCollectionView reloadData];
                           }];
}

#pragma mark Gesture Method -
- (void)hideDetailsView: (UIGestureRecognizer *)gesture
{
    [_detailsView setHidden:YES];
    
    MMTCollectionViewCell *cell = (MMTCollectionViewCell *)[_dateCollectionView cellForItemAtIndexPath:selectedIndexPath];
        cell.contentView.backgroundColor = [UIColor lightTextColor];

}
@end
