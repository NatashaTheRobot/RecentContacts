//
//  NTRContact+NTRExtensions.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/21/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRContact+NTRExtensions.h"
#import "APAddressBook.h"
#import "APContact.h"
#import "NTRPhone+NTRExtensions.h"
#import "NTREmail+NTRExtensions.h"

@implementation NTRContact (NTRExtensions)

+ (void)retrieveFromAddressBook
{
    APAddressBook *addressBook = [[APAddressBook alloc] init];
    addressBook.fieldsMask = APContactFieldAll;
    
    [addressBook loadContacts:^(NSArray *contacts, NSError *error) {
        if (contacts) {
            [contacts enumerateObjectsUsingBlock:^(APContact *contact, NSUInteger idx, BOOL *stop) {
                
                NTRContact *existingContact = [NTRContact MR_findFirstByAttribute:@"recordID" withValue:contact.recordID];
                // creation date should never change for an existing contact!
                if (existingContact)
                {
                    [existingContact clearExistingEmails];
                    [existingContact clearExistingPhones];
                    [existingContact populateDataFromContact:contact];
                }
                else
                {
                    NTRContact *newContact = [NTRContact MR_createEntity];
                    newContact.recordID = contact.recordID;
                    newContact.creationDate = contact.creationDate;
                    [newContact populateDataFromContact:contact];
                }
            }];
            
            [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
                
            } completion:^(BOOL success, NSError *error) {
                
            }];
        } else {
            // HANDLE ERROR
        }
    }];
}

#pragma mark - Private Helper Methods

- (void)clearExistingPhones
{
    [self.phones enumerateObjectsUsingBlock:^(NTRPhone *phone, BOOL *stop) {
        [phone MR_deleteEntity];
    }];
}

- (void)clearExistingEmails
{
    [self.emails enumerateObjectsUsingBlock:^(NTREmail *email, BOOL *stop) {
        [email MR_deleteEntity];
    }];
}

- (void)populateDataFromContact:(APContact *)contact
{
    self.firstName = contact.firstName;
    self.lastName = contact.lastName;
    self.compositeName = contact.compositeName;
    self.company = contact.company;
    self.modificationDate = contact.modificationDate;
    [self addEmails:[NTREmail emailsFromEmailsArray:contact.emails]];
    [self addPhones:[NTRPhone phonesFromPhonesArray:contact.phonesWithLabels]];
    self.photoPath = [self processImage:contact.photo withExtension:@"photo" existingImagePath:self.photoPath];
    self.thumbnailPath = [self processImage:contact.thumbnail withExtension:@"thumbnail" existingImagePath:self.thumbnailPath];
}

- (NSString *)processImage:(UIImage *)image withExtension:(NSString *)extension existingImagePath:(NSString *)existingImagePath
{
    if (image && !existingImagePath) {
        NSData *imageData = UIImagePNGRepresentation(image);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@.png", self.recordID, extension]];
        if (![imageData writeToFile:imagePath atomically:NO]) {
            return nil;
        } else {
            return imagePath;
        }
    }
    else if (existingImagePath) {
        return existingImagePath;
    }
    else {
        return nil;
    }

}

@end
