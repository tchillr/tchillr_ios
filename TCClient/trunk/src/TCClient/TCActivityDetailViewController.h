//
//  TCActivityDetailViewController.h
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCActivity.h"

@interface TCActivityDetailViewController : UIViewController

@property (nonatomic, retain) TCActivity * activity;

@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityShortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityFullAdressLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *activityTagsView;
@property (weak, nonatomic) IBOutlet UILabel *activityNextOccurenceLabel;

@end

