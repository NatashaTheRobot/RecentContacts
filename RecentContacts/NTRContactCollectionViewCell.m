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

@interface NTRContactCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NTRContactCollectionViewCell

- (void)prepareForReuse
{
    self.contactImageView.image = nil;
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

@end
