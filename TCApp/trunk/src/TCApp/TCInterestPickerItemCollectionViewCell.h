//
//  InterestItemCollectionViewCell.h
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTagItemCollectionViewCell.h"

@class TCInterestPickerItemCollectionViewCell;
@class TCTag;

@protocol TCInterestPickerItemCollectionViewCellDelegate <NSObject>

- (void)interestPickerItemCollectionViewCell:(TCInterestPickerItemCollectionViewCell *)cell frontViewHasBeenTapped:(UIView *)frontView;
- (NSUInteger)interestPickerItemCollectionViewCellNumberOfTags:(TCInterestPickerItemCollectionViewCell *)cell;
- (TCTag*)interestPickerItemCollectionViewCell:(TCInterestPickerItemCollectionViewCell *)cell tagForItemAtIndex:(NSUInteger)index;

@end

@interface TCInterestPickerItemCollectionViewCell : UICollectionViewCell <UICollectionViewDataSource, UICollectionViewDelegate, TagItemCollectionViewCellDelegate>

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIColor *frontColor;

@property (nonatomic, assign) id<TCInterestPickerItemCollectionViewCellDelegate> delegate;

@property (nonatomic, assign, readonly, getter = isOpen) BOOL open;

- (void)openCellAnimated:(void (^)(void))complete;
- (void)closeCellAnimated:(void (^)(void))complete;
- (void)openCell;
- (void)closeCell;

@end
