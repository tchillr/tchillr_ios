//
//  JASegmentedControl.h
//  JASegmentedControl
//
//  Created by Jad Abi-Abdallah on 28/11/12.
//  Copyright (c) 2012 Inertia. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface JASegmentedControl : UIControl

@property(nonatomic,  assign) NSUInteger selectedSegmentIndex;
@property (nonatomic, assign) NSUInteger numberOfSegments;
@property (nonatomic, retain) NSMutableArray* buttons;
@property (nonatomic, assign) BOOL pagingEnabled;
@property (nonatomic, retain) NSArray * titles;
@property (nonatomic, retain) UIImageView * backgroundImageView;

-(void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state andIndex:(NSUInteger)index;
-(void)setFont:(UIFont*)font;
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;
-(void)setTitleColor:(UIColor*)textColor forState:(UIControlState)state;
-(void)setTitleShadowColor:(UIColor*)shadowColor forState:(UIControlState)state;
-(void)setTitles:(NSArray *)titles forState:(UIControlState)state;
- (void)setStretchableBackgroundImage:(UIImage *)image forState:(UIControlState)state;

-(UIButton*)buttonAtIndex:(NSUInteger)index;
-(void)button:(UIButton *)button isDisabled:(BOOL)disabled;

-(void)buttonClicked:(UIButton *)button;
-(CGSize)contentSize;
-(void)adjustFrameToContentSize;
@end
