//
//  TCActivityTableViewCell.h
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityShortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityFullAdressLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityContextualTags;
@property (weak, nonatomic) IBOutlet UIView *activityContextualTagsView;
@property (weak, nonatomic) IBOutlet UILabel *activityNextOccurenceLabel;

@end
