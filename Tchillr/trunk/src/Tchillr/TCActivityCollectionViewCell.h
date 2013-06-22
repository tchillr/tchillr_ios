//
//  TCActivityCollectionViewCell.h
//  Tchillr
//
//  Created by Jad on 20/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCActivityCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UILabel * activityDayLabel;
@property (nonatomic, retain) IBOutlet UILabel * activityTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel * activityShortDescriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel * activityTagsLabel;
@property (nonatomic, retain) IBOutlet UILabel * activityDistanceLabel;
@property (nonatomic, retain) IBOutlet UIImageView * activityImageView;
@property (nonatomic, retain) IBOutlet UIImageView * activityHeartImageView;

@end
