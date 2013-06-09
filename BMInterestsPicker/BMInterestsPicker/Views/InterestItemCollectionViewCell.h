//
//  InterestItemCollectionViewCell.h
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagItemCollectionViewCell.h"

@class InterestItemCollectionViewCell;

@protocol InterestItemCollectionViewCellDelegate <NSObject>

-(void)interestItemCollectionViewCell:(InterestItemCollectionViewCell *)cell frontViewHasBeenTapped:(UIView *)frontView;

@end

@interface InterestItemCollectionViewCell : UICollectionViewCell <UICollectionViewDataSource, UICollectionViewDelegate, TagItemCollectionViewCellDelegate>

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIColor *frontColor;

@property (nonatomic, assign) id<InterestItemCollectionViewCellDelegate> delegate;

@property (nonatomic, assign, readonly, getter = isOpen) BOOL open;

- (void)openCellAnimated:(void (^)(void))complete;
- (void)closeCellAnimated:(void (^)(void))complete;
- (void)openCell;
- (void)closeCell;

@end
