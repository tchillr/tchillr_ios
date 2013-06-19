//
//  TCInterestView.h
//  Tchillr
//
//  Created by Jad on 18/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCInterestView;

@protocol TCInterestViewDelegate <NSObject>
#pragma mark - TCInterestViewDelegate methods
- (void) userDidTapInterestView:(TCInterestView *)interestView atIndex:(NSInteger)index;
@end

@interface TCInterestView : UIView

@property (nonatomic, assign) id<TCInterestViewDelegate> delegate;
@property (nonatomic, assign) BOOL selected;

#pragma mark Lifecycle
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title;

@end
