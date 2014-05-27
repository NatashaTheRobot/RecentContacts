//
//  NTREmailTableViewCell.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/26/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRContactEmailTableViewCell.h"
#import "NTREmail+NTRExtensions.h"

@implementation NTRContactEmailTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)configureWithEmail:(NTREmail *)email
{
    self.textLabel.text = email.address;
}

@end
