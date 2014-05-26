//
//  NTRContactPhoneTableViewCell.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/26/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRContactPhoneTableViewCell.h"

@implementation NTRContactPhoneTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"call"]];
}

@end
