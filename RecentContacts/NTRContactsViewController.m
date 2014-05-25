//
//  NTRContactsViewController.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/19/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRContactsViewController.h"
#import "NTRContactCollectionViewCell.h"
#import "NTRContact+NTRExtensions.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface NTRContactsViewController ()

@property (strong, nonatomic) NSArray *recentContacts;

@end

@implementation NTRContactsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onContactsRetrievalSuccess) name:NTRNotificationContactsSavedSuccess object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onContactsRetrievalFailure:) name:NTRNotificationContactsSavedFailure object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NTRContact retrieveFromAddressBook];
    [self registerCollectionViewCellsFromNib];
}

- (void)viewDidLayoutSubviews
{
    [SVProgressHUD showWithStatus:@"Retrieving Latests Contacts" maskType:SVProgressHUDMaskTypeNone];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)onContactsRetrievalSuccess
{
    self.recentContacts = [NTRContact recentContactsFromAddressBook];
    [SVProgressHUD dismiss];
    [self.collectionView reloadData];
}

- (void)onContactsRetrievalFailure:(NSError *)error
{
    [SVProgressHUD dismiss];
    // TODO: HANDLE ERROR
}

#pragma mark - CollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.recentContacts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NTRContactCollectionViewCell *contactCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NTRContactCollectionViewCell class]) forIndexPath:indexPath];
    contactCell.contact = self.recentContacts[indexPath.row];
    return contactCell;
}

#pragma mark - Setting Overrides

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Private Helper Classes

- (void)registerCollectionViewCellsFromNib
{
    NSString *cellIdentifier = NSStringFromClass([NTRContactCollectionViewCell class]);
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

@end
