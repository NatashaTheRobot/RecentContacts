//
//  NSSet+NTRExtensions.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/27/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NSSet+NTRExtensions.h"

@implementation NSSet (NTRExtensions)

- (BOOL)isEmpty
{
    return (self == nil || [self count] == 0);
}

@end
