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

@interface NTRContactCollectionViewCell () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSNumber *sectionIndexForName;
@property (strong, nonatomic) NSNumber *sectionIndexForPhones;
@property (strong, nonatomic) NSNumber *sectionIndexForEmails;

@end

@implementation NTRContactCollectionViewCell

- (void)prepareForReuse
{
    self.contactImageView.image = nil;
}

- (void)awakeFromNib
{
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
}

- (void)setContact:(NTRContact *)contact
{
    _contact = contact;
    if (contact.thumbnailPath) {
        self.contactImageView.image = [UIImage imageWithContentsOfFile:contact.thumbnailPath];
        self.contactImageView.layer.cornerRadius = self.contactImageView.frame.size.width / 2;
        self.contactImageView.layer.masksToBounds = YES;
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
    
    if(self.contact.phones && [self.contact.phones count] > 0) {
        self.sectionIndexForPhones = [NSNumber numberWithInteger:numberOfSections];
        numberOfSections++;
    }
    
    if(self.contact.emails && [self.contact.emails count] > 0) {
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
//        phoneCell.textLabel.text = [self.contact.phones allObjects][indexPath.row];
        phoneCell.textLabel.text = @"202-412-4678";
        cell = phoneCell;
    }
    
    if(self.sectionIndexForEmails && indexPath.section == [self.sectionIndexForEmails integerValue]) {
        NTRContactEmailTableViewCell *emailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NTRContactEmailTableViewCell class])];
//        emailCell.textLabel.text = [self.contact.emails allObjects][indexPath.row];
        emailCell.textLabel.text = @"natasha@natashatherobot.com";
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
