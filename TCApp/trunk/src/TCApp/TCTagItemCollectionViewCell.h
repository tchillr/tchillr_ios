//
//  TagItemCollectionViewCell.h
//  BMInterestsPicker
//
//  Created by Meski Badr on 09/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCTagItemCollectionViewCell;
@class TCTagView;

@protocol TagItemCollectionViewCellDelegate <NSObject>

-(void)tagItemCollectionViewCellHasBeenTapped:(TCTagItemCollectionViewCell *)cell;

@end

@interface TCTagItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) IBOutlet TCTagView * tagView;
@property (nonatomic, assign) id<TagItemCollectionViewCellDelegate> delegate;

@end
