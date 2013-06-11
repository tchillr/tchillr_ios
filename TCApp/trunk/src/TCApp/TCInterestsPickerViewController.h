//
//  ViewController.h
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCInterestModelDelegate.h"
#import "TCInterestPickerItemCollectionViewCell.h"

@class ViewController;
@class TCInterestsPickerViewController;

@protocol TCInterestsPickerViewControllerDelegate <NSObject>

- (void)interestsPickerViewControllerDidPushBack:(TCInterestsPickerViewController *)controller;

@end

@interface TCInterestsPickerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, TCInterestPickerItemCollectionViewCellDelegate,TCInterestModelDelegate>

@property (nonatomic, weak) id<TCInterestsPickerViewControllerDelegate> delegate;

- (IBAction)backButtonTapped:(UIButton *)button;

@end
