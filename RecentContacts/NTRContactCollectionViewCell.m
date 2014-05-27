//
//  NTRPersonCollectionViewCell.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/20/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRContactCollectionViewCell.h"
#import "UIImage+ImageEffects.h"
#import "NTRContact+NTRExtensions.h"
#import "NTRContactPhoneTableViewCell.h"
#import "NTRContactEmailTableViewCell.h"
#import "NTRContactNameTableViewCell.h"
#import "NSSet+NTRExtensions.h"
#import "NSString+NTRExtensions.h"
#import <Shimmer/FBShimmeringView.h>

@interface NTRContactCollectionViewCell () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (strong, nonatomic) FBShimmeringView *shimmeringView;

@property (strong, nonatomic) NSNumber *sectionIndexForName;
@property (strong, nonatomic) NSNumber *sectionIndexForPhones;
@property (strong, nonatomic) NSNumber *sectionIndexForEmails;

@end

@implementation NTRContactCollectionViewCell

- (void)prepareForReuse
{
    [self.profileView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view removeFromSuperview];
    }];
    self.sectionIndexForEmails = nil;
    self.sectionIndexForPhones = nil;
    self.sectionIndexForName = nil;
    [self.shimmeringView removeFromSuperview];
}

- (void)awakeFromNib
{
    self.profileView.layer.cornerRadius = self.profileView.frame.size.width / 2;
    self.profileView.layer.masksToBounds = YES;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self registerTableViewViewCellsFromNib];
}

#pragma mark - Setter Overrides

- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    NSString *backgroundImageName = index % 2 ? @"sampleImageUpsideDown" : @"sampleBackground";
    UIImage *backgroundImage = [UIImage imageNamed:backgroundImageName];
    
    self.backgroundImageView.image = [backgroundImage applyLightEffect];
    
    if (index == 0) {
        self.shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
        [self addSubview:self.shimmeringView];
        
        UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.shimmeringView.bounds];
        loadingLabel.textAlignment = NSTextAlignmentCenter;
        loadingLabel.text = @">";
        loadingLabel.font = [UIFont systemFontOfSize:30.0f];
        loadingLabel.textColor = [UIColor whiteColor];
        self.shimmeringView.contentView = loadingLabel;
        
        self.shimmeringView.transform = CGAffineTransformMakeRotation(M_PI/2);
        // Start shimmering.
        self.shimmeringView.shimmering = YES;
    }
}

- (void)setContact:(NTRContact *)contact
{
    _contact = contact;
    if (contact.thumbnailPath) {
        
        UIImageView *contactImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.profileView.frame.size.width, self.profileView.frame.size.height)];
        contactImageView.image = [UIImage imageWithContentsOfFile:contact.thumbnailPath];
        
        [self.profileView addSubview:contactImageView];
    } else {
        self.profileView.backgroundColor = [UIColor purpleColor];
        
        // creating label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.profileView.frame.size.width, self.profileView.frame.size.height)];
        label.text = [contact.compositeName initialsString];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self.profileView addSubview:label];
    }
    [self.tableView reloadData];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = 0;
    
    if(self.contact.compositeName) {
        self.sectionIndexForName = [NSNumber numberWithInteger:numberOfSections];
        numberOfSections ++;
    }
    
    if(![self.contact.phones isEmpty]) {
        self.sectionIndexForPhones = [NSNumber numberWithInteger:numberOfSections];
        numberOfSections++;
    }
    
    if(![self.contact.emails isEmpty]) {
        self.sectionIndexForEmails = [NSNumber numberWithInteger:numberOfSections];
        numberOfSections++;
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(self.sectionIndexForName && section == [self.sectionIndexForName integerValue]) {
        return 1;
    }
    
    if(self.sectionIndexForPhones && section == [self.sectionIndexForPhones integerValue]) {
        return [self.contact.phones count];
    }
    
    if(self.sectionIndexForEmails && section == [self.sectionIndexForEmails integerValue]) {
        return [self.contact.emails count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(self.sectionIndexForName && indexPath.section == [self.sectionIndexForName integerValue]) {
        NTRContactNameTableViewCell *nameCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NTRContactNameTableViewCell class])];
        nameCell.textLabel.text = self.contact.compositeName;
        cell = nameCell;
    }
    
    if(self.sectionIndexForPhones && indexPath.section == [self.sectionIndexForPhones integerValue]) {
        NTRContactPhoneTableViewCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NTRContactPhoneTableViewCell class])];
        [phoneCell configureWithPhone:([self.contact.phones allObjects][indexPath.row])];
        cell = phoneCell;
    }
    
    if(self.sectionIndexForEmails && indexPath.section == [self.sectionIndexForEmails integerValue]) {
        NTRContactEmailTableViewCell *emailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NTRContactEmailTableViewCell class])];
        [emailCell configureWithEmail:([self.contact.emails allObjects][indexPath.row])];
        cell = emailCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Private Helper Classes

- (void)registerTableViewViewCellsFromNib
{
    NSArray* cellIdentifiers = @[NSStringFromClass([NTRContactPhoneTableViewCell class]),
                               NSStringFromClass([NTRContactEmailTableViewCell class]),
                               NSStringFromClass([NTRContactNameTableViewCell class])];
    
    for(NSString *cellIdentifier in cellIdentifiers) {
        [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
    }
}

@end
