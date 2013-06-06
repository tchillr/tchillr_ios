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

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

