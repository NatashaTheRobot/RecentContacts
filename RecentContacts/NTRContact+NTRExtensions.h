//
//  NTRContact+NTRExtensions.h
//  RecentContacts
//
//  Created by Natasha Murashev on 5/21/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRContact.h"

@interface NTRContact (NTRExtensions)

+ (void)retrieveFromAddressBook;
+ (NSArray *)recentContactsFromAddressBook;

@end
