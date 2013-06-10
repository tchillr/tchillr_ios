//
//  ViewController.h
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterestItemCollectionViewCell.h"

@interface InterestsPickerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, InterestItemCollectionViewCellDelegate>

@end
