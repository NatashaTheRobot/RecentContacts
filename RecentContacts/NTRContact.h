//
//  NTRContact.h
//  RecentContacts
//
//  Created by Natasha Murashev on 5/27/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NTREmail, NTRPhone;

@interface NTRContact : NSManagedObject

@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * compositeName;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSDate * modificationDate;
@property (nonatomic, retain) NSNumber * recordID;
@property (nonatomic, retain) NSString * thumbnailPath;
@property (nonatomic, retain) NSSet *emails;
@property (nonatomic, retain) NSSet *phones;
@end

@interface NTRContact (CoreDataGeneratedAccessors)

- (void)addEmailsObject:(NTREmail *)value;
- (void)removeEmailsObject:(NTREmail *)value;
- (void)addEmails:(NSSet *)values;
- (void)removeEmails:(NSSet *)values;

- (void)addPhonesObject:(NTRPhone *)value;
- (void)removePhonesObject:(NTRPhone *)value;
- (void)addPhones:(NSSet *)values;
- (void)removePhones:(NSSet *)values;

@end
