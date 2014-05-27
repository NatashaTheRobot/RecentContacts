//
//  NSString+NTRExtensions.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/27/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NSString+NTRExtensions.h"

@implementation NSString (NTRExtensions)

- (NSString *)initialsString
{
    NSArray *words = [self componentsSeparatedByString:@" "];
    NSMutableString *initials = [[NSMutableString alloc] initWithCapacity:[words count]];
    for (NSString *word in words) {
        [initials appendString:[word substringToIndex:1]];
    }
    return [initials uppercaseString];
}

@end
