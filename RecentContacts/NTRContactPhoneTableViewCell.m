//
//  NTRContactPhoneTableViewCell.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/26/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRContactPhoneTableViewCell.h"
#import "NTRPhone+NTRExtensions.h"

@interface NTRContactPhoneTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@end

@implementation NTRContactPhoneTableViewCell

- (void)configureWithPhone:(NTRPhone *)phone
{
    self.phoneLabel.text = phone.phoneNumber;
}

#pragma mark - Actions

- (IBAction)onTextButtonTap:(id)sender
{
    
}

- (IBAction)onCallButtonTap:(id)sender
{
    
}

@end
