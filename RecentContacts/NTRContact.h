//
//  NTRContact.h
//  RecentContacts
//
//  Created by Natasha Murashev on 5/21/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NTRContact : NSManagedObject

@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * compositeName;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSDate * modificationDate;
@property (nonatomic, retain) NSString * photoPath;
@property (nonatomic, retain) NSNumber * recordID;
@property (nonatomic, retain) NSString * thumbnailPath;
@property (nonatomic, retain) NSSet *phones;
@property (nonatomic, retain) NSSet *emails;
@end

@interface NTRContact (CoreDataGeneratedAccessors)

- (void)addPhonesObject:(NSManagedObject *)value;
- (void)removePhonesObject:(NSManagedObject *)value;
- (void)addPhones:(NSSet *)values;
- (void)removePhones:(NSSet *)values;

- (void)addEmailsObject:(NSManagedObject *)value;
- (void)removeEmailsObject:(NSManagedObject *)value;
- (void)addEmails:(NSSet *)values;
- (void)removeEmails:(NSSet *)values;

@end
