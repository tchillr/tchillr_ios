//
//  UIView+Additions.h
//  ArretCardiaque
//
//  Created by badr meski on 15/10/13.
//  Copyright (c) 2013 MobiCrea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

- (void)changeFrameOriginY:(CGFloat)delta;
- (void)changeFrameOriginX:(CGFloat)delta;
- (void)changeFrameSizeWidth:(CGFloat)delta;
- (void)changeFrameSizeHeight:(CGFloat)delta;

- (void)setPosY:(CGFloat)newYPos;
- (void)setPosX:(CGFloat)newXPos;
- (void)setWidth:(CGFloat)newWidth;
- (void)setHeight:(CGFloat)newHeight;

- (void)addSubviews:(NSArray *)subviews;

@end
