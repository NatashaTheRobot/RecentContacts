//
//  NTRContactsViewController.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/19/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRContactsViewController.h"
@import AddressBook;
#import "APAddressBook.h"
#import "NTRPersonCollectionViewCell.h"

@interface NTRContactsViewController ()


@end

@implementation NTRContactsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerCollectionViewCellsFromNib];
}

#pragma mark - CollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NTRPersonCollectionViewCell *personCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NTRPersonCollectionViewCell class]) forIndexPath:indexPath];
    return personCell;
}

#pragma mark - Setting Overrides

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Private Helper Classes

- (void)registerCollectionViewCellsFromNib
{
    NSString *cellIdentifier = NSStringFromClass([NTRPersonCollectionViewCell class]);
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

@end
