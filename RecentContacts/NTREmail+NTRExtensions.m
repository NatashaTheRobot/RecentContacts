//
//  NTREmail+NTRExtensions.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/21/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTREmail+NTRExtensions.h"

@implementation NTREmail (NTRExtensions)

+ (NSSet *)emailsFromEmailsArray:(NSArray *)emails
{
    NSMutableSet *newEmails = [[NSMutableSet alloc] initWithCapacity:[emails count]];
    
    [emails enumerateObjectsUsingBlock:^(NSString *email, NSUInteger idx, BOOL *stop) {
        NTREmail *newEmail = [NTREmail MR_createEntity];
        newEmail.address = email;
        [newEmails addObject:newEmail];
    }];
    
    return [newEmails copy];
}

@end
