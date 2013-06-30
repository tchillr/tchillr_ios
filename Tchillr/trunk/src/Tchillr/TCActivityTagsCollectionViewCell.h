//
//  TCActivityTagsCollectionView.h
//  Tchillr
//
//  Created by Jad on 28/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCActivityTagsCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel * tagName;
@property (nonatomic, weak) IBOutlet UIImageView * tagSelectionImageView;
@property (nonatomic, assign) BOOL userInterest;

@end
