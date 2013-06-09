//
//  TCTagTableViewCell.h
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTagView.h"

@class TCTagTableViewCell;

#pragma mark TCTagTableViewCellDelegate
@protocol TCTagTableViewCellDelegate <NSObject>
- (void)tagTableViewCellDidAddInterest:(TCTagTableViewCell *)cell;
@end

@interface TCTagTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet TCTagView * tagView;
@property (nonatomic, assign) id<TCTagTableViewCellDelegate> delegate;

@end
