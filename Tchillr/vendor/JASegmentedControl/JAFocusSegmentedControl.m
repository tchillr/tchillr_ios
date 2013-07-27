//
//  PWFocusSegmentedControl.m
//  JASegmentedControl
//
//  Created by Jad Abi-Abdallah on 30/11/12.
//  Copyright (c) 2012 Inertia. All rights reserved.
//

#import "JAFocusSegmentedControl.h"

#define SELECTION_INDICATOR_HEIGHT 14

@interface JAFocusSegmentedControl()

@property (nonatomic, retain) UIImageView * indicatorImageView;

@end

@implementation JAFocusSegmentedControl

@synthesize indicatorImageView = _indicatorImageView;
- (UIView *)indicatorView {
    if (_indicatorImageView == nil) {
        _indicatorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,[self superview].frame.size.height - SELECTION_INDICATOR_HEIGHT, SELECTION_INDICATOR_HEIGHT, SELECTION_INDICATOR_HEIGHT)];
        _indicatorImageView.image = [UIImage imageNamed:@"back"];
        [self addSubview:_indicatorImageView];
    }
    return _indicatorImageView;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    for (UIButton * b in self.buttons) {
        [b setFrame:CGRectMake(b.frame.origin.x,b.frame.origin.y,b.frame.size.width,b.frame.size.height- self.indicatorView.frame.size.height)];
    }
    
    self.indicatorImageView.hidden = (self.selectedSegmentIndex == NSNotFound);
    if (self.selectedSegmentIndex != NSNotFound) {
        CGPoint center = [self centerWithFocusButton];
        [self.indicatorImageView setCenter:center];
    }
}

-(CGPoint)centerWithFocusButton{
    UIButton * bSelected = (UIButton*)[self.buttons objectAtIndex:self.selectedSegmentIndex];
    return CGPointMake(bSelected.center.x, self.frame.size.height - SELECTION_INDICATOR_HEIGHT/2);
}

-(void)buttonClicked:(UIButton *)button{
    [super buttonClicked:button];
    CGPoint newCenterPoint = [self centerWithFocusButton];
    [UIView animateWithDuration:0.1f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{self.indicatorImageView.center = newCenterPoint;}
                         completion:^(BOOL finished) {
                             [self setNeedsLayout];
                         }];
}


@end
