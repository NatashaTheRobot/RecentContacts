//
//  NTRPersonCollectionViewCell.m
//  RecentContacts
//
//  Created by Natasha Murashev on 5/20/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

#import "NTRPersonCollectionViewCell.h"
#import "UIImage+ImageEffects.h"

@interface NTRPersonCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation NTRPersonCollectionViewCell

- (void)awakeFromNib
{
    UIImage *image = [UIImage imageNamed:@"sampleBackground"];
    
    self.backgroundImageView.image = [image applyLightEffect];
}

@end
