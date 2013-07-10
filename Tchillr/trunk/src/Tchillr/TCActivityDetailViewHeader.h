//
//  TCActivityDetailViewHeader.h
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TCTriangleView;

@interface TCActivityDetailViewHeader : UIView

@property (nonatomic, retain) IBOutlet UILabel * nameLabel;
@property (nonatomic, retain) IBOutlet UILabel * dayLabel;
@property (nonatomic, retain) IBOutlet UILabel * timeLabel;
@property (nonatomic, retain) IBOutlet UILabel * shortDescriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel * feeLabel;

@property (nonatomic, retain) IBOutlet TCTriangleView * triangleView;

- (CGSize) idealSize;

@end
