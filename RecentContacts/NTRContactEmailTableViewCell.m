//
//  NTREmailTableViewCell.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/26/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRContactEmailTableViewCell.h"
#import "NTREmail+NTRExtensions.h"

@interface NTRContactEmailTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;


@end

@implementation NTRContactEmailTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)configureWithEmail:(NTREmail *)email
{
    self.emailLabel.text = email.address;
}

#pragma mark - Actions

- (IBAction)onEmailButtonTap:(id)sender
{
    
}


@end
