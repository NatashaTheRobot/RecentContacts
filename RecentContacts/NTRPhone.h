//
//  NTRPhone.h
//  RecentContacts
//
//  Created by Natasha Murashev on 5/21/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NTRContact;

@interface NTRPhone : NSManagedObject

@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NTRContact *contact;

@end
