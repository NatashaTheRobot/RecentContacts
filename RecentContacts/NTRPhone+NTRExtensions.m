//
//  NTRPhone+NTRExtensions.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/21/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRPhone+NTRExtensions.h"
#import "APPhoneWithLabel.h"

@implementation NTRPhone (NTRExtensions)

+ (NSSet *)phonesFromPhonesArray:(NSArray *)phones
{
    NSMutableSet *newPhones = [[NSMutableSet alloc] initWithCapacity:[phones count]];
    
    [phones enumerateObjectsUsingBlock:^(APPhoneWithLabel *phone, NSUInteger idx, BOOL *stop) {
        NTRPhone *newPhone = [NTRPhone MR_createEntity];
        newPhone.phoneNumber = phone.phone;
        newPhone.label = phone.label;
        [newPhones addObject:newPhone];
    }];
    
    return [newPhones copy];
}

@end
