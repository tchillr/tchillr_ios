//
//  UIView+Additions.m
//  ArretCardiaque
//
//  Created by badr meski on 15/10/13.
//  Copyright (c) 2013 MobiCrea. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (CGRect)getTranslatedFrameY:(CGFloat)delta {
    return CGRectMake(self.frame.origin.x, self.frame.origin.y+delta, self.frame.size.width, self.frame.size.height);
}
- (CGRect)getTranslatedFrameX:(CGFloat)delta {
    return CGRectMake(self.frame.origin.x+delta, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
- (CGRect)getTranslatedFrameWidth:(CGFloat)delta {
    return CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+delta, self.frame.size.height);
}
- (CGRect)getTranslatedFrameHeight:(CGFloat)delta {
    return CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+delta);
}

- (void)changeFrameOriginY:(CGFloat)delta {
    self.frame = [self getTranslatedFrameY:delta];
}
- (void)changeFrameOriginX:(CGFloat)delta {
    self.frame = [self getTranslatedFrameX:delta];
}
- (void)changeFrameSizeWidth:(CGFloat)delta {
    self.frame = [self getTranslatedFrameWidth:delta];
}
- (void)changeFrameSizeHeight:(CGFloat)delta {
    self.frame = [self getTranslatedFrameHeight:delta];
}

- (void)setPosY:(CGFloat)newYPos {
    [self setFrame:CGRectMake(self.frame.origin.x, newYPos, self.frame.size.width, self.frame.size.height)];
}
- (void)setPosX:(CGFloat)newXPos {
    [self setFrame:CGRectMake(newXPos, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
}
- (void)setWidth:(CGFloat)newWidth {
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height)];
}
- (void)setHeight:(CGFloat)newHeight {
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight)];
}

- (void)addSubviews:(NSArray *)subviews {
    for (UIView *subview in subviews) {
        [self addSubview:subview];
    }
}

@end
