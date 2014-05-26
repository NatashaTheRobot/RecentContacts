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

@interface NTRContactCollectionViewCell () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NTRContactCollectionViewCell

- (void)prepareForReuse
{
    self.contactImageView.image = nil;
}

- (void)awakeFromNib
{
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
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    if(self.contact.compositeName) {
        numberOfRows ++;
    }
    
    if(self.contact.emails) {
        numberOfRows += [self.contact.emails count];
    }
    
    if(self.contact.phones) {
        numberOfRows += [self.contact.phones count];
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NTRContactPhoneTableViewCell *phoneCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NTRContactPhoneTableViewCell class])];
    phoneCell.textLabel.text = @"hello";
    
    return phoneCell;
}

#pragma mark - Private Helper Classes

- (void)registerTableViewViewCellsFromNib
{
    NSString *cellIdentifier = NSStringFromClass([NTRContactPhoneTableViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

@end
