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

@end

@implementation NTRContactCollectionViewCell

- (void)awakeFromNib
{
    UIImage *image = [UIImage imageNamed:@"sampleBackground"];
    
    self.backgroundImageView.image = [image applyLightEffect];
}

- (void)setContact:(NTRContact *)contact
{
    _contact = contact;
    NSLog(@"%@", contact.compositeName);
}

@end
