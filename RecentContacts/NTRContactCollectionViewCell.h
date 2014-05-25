//
//  NTRPersonCollectionViewCell.h
//  RecentContacts
//
//  Created by Natasha Murashev on 5/20/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

@class NTRContact;

@interface NTRContactCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NTRContact *contact;
@property (assign, nonatomic) NSInteger index;

@end
