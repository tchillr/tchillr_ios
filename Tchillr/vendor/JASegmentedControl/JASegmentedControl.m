//
//  JASegmentedControl.m
//  JASegmentedControl
//
//  Created by Jad Abi-Abdallah on 28/11/12.
//  Copyright (c) 2012 Inertia. All rights reserved.
//

#import "JASegmentedControl.h"

@interface JASegmentedControl()

@property (nonatomic,assign) CGRect initialFrame;

@end

@implementation JASegmentedControl

@synthesize buttons = _buttons;
@synthesize titles = _titles;
@synthesize pagingEnabled = _pagingEnabled;
@synthesize initialFrame = _initialFrame;
@synthesize backgroundImageView = _backgroundImageView;

-(void)setTitles:(NSArray *)titles forState:(UIControlState)state{
    self.titles = titles;
    for (int i=0;i<[self.buttons count];i++) {
        UIButton * button = (UIButton*) [self.buttons objectAtIndex:i];
        NSString * title = [self.titles objectAtIndex:i];
        [button setTitle:title forState:state];
    }
    [self setNeedsLayout];
}

-(void)setFont:(UIFont*)font{
    [self.buttons makeObjectsPerformSelector:@selector(setFont:) withObject:font];
    [self setNeedsLayout];
}

@synthesize numberOfSegments = _numberOfSegments;
-(void) setNumberOfSegments:(NSUInteger)numberOfSegments{
    _numberOfSegments = numberOfSegments;
    self.buttons = [NSMutableArray arrayWithCapacity:_numberOfSegments];
    for (int i = 0; i < self.numberOfSegments; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button.titleLabel setNumberOfLines:1];
        [self.buttons addObject:button];
    }
    [self setNeedsLayout];
}

- (NSUInteger)numberOfSegments{
    return _numberOfSegments;
}

@synthesize selectedSegmentIndex = _selectedSegmentIndex;
- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex {
	if (_selectedSegmentIndex != selectedSegmentIndex) {
		_selectedSegmentIndex = selectedSegmentIndex;
        if (selectedSegmentIndex != NSNotFound) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            for (int i = 0; i < [self.buttons count]; i++) {
                UIButton * b = (UIButton *)[self.buttons objectAtIndex:i];
                [b setSelected:(i == _selectedSegmentIndex)];
                
            }
        }
	}
}

#pragma mark - View Lifecycle
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNeedsLayout];
        self.initialFrame = frame;
    }
    return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
    self.selectedSegmentIndex = NSNotFound;
}

#pragma mark - Setup
-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.backgroundImageView) {
        [self.backgroundImageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.backgroundImageView];
    }
    
    for (int i = 0; i < self.numberOfSegments; i++) {
        UIButton * button = (UIButton*)[self.buttons objectAtIndex:i];
        CGSize s = [self contentOffsetForSegmentAtIndex:i];
        CGFloat width = [self widthForSegmentAtIndex:i];
        CGRect frm = CGRectMake(s.width,s.height,width,self.frame.size.height);
        [button setFrame:frm];
        [button setTag:i];        
        [self addSubview:button];
    }
    
    [self adjustFrameToContentSize];
}

#pragma mark - Accessing segments
// In this example segments are UIButton classes
- (UIButton *)buttonAtIndex:(NSUInteger)index {
	UIButton *button = nil;
	if (index < [self numberOfSegments]) {
		button = [self.buttons objectAtIndex:index];
	}
	return button;
}

-(void)button:(UIButton *)button isDisabled:(BOOL)disabled {
    if(disabled) {
        [button setAlpha:0.3];
        [button removeTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [button setAlpha:1];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - Managing events

-(void)buttonClicked:(UIButton *)button{
    self.selectedSegmentIndex = button.tag;
}

#pragma mark - Managing Segment Behavior and Appearance

- (CGSize)contentOffsetForSegmentAtIndex:(NSUInteger)segment{
    CGSize contentOffsetForSegmentAtIndex = CGSizeZero;
    if (self.pagingEnabled) {
        for (int i = 0; i < segment; i++) {
            contentOffsetForSegmentAtIndex.width += [self widthForSegmentAtIndex:i];
        }
    }else{
        CGFloat itemWidth = floorf(self.frame.size.width / self.numberOfSegments);
        contentOffsetForSegmentAtIndex = CGSizeMake(segment * itemWidth,0);
    }
    return contentOffsetForSegmentAtIndex;
}

- (CGFloat)widthForSegmentAtIndex:(NSUInteger)segment{
    CGFloat widthForSegmentAtIndex = 0;
    if (self.pagingEnabled) {
        widthForSegmentAtIndex = floorf(self.initialFrame.size.width / 3);
    }else{
        widthForSegmentAtIndex = floorf(self.frame.size.width / self.numberOfSegments);
    }
    return widthForSegmentAtIndex;
}

-(CGSize)contentSize{
    CGSize contentSize = CGSizeZero;
    if (self.pagingEnabled) {
        for (int i = 0; i < self.numberOfSegments; i++) {
            contentSize.width += [self widthForSegmentAtIndex:i];
        }
        contentSize.height = self.frame.size.height;
    }else{
        
    }
    return contentSize;
}

-(void)adjustFrameToContentSize{
    if (self.pagingEnabled) {
        CGSize contentSize = [self contentSize];
        CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, contentSize.width, contentSize.height);
        [self setFrame:rect];
        NSLog(@"Frame for segmented control %@",NSStringFromCGRect(rect));
    }
}

#pragma mark - Managing Segment Content

-(UIImage*)imageForSegmentAtIndex:(NSUInteger)index{
    return [self buttonAtIndex:index].imageView.image;
}

-(NSString*)titleForSegmentAtIndex:(NSUInteger)index andForState:(UIControlState)state{
    return [[self buttonAtIndex:index] titleForState:state];
}

#pragma mark - Customizing Appearance

- (UIImage *)backgroundImageForState:(UIControlState)state andIndex:(NSUInteger)index{
    return [[self buttonAtIndex:index] backgroundImageForState:state];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state andIndex:(NSUInteger)index{
    [[self buttonAtIndex:index] setBackgroundImage:backgroundImage forState:state];
}

-(void) setTitleColor:(UIColor*)textColor forState:(UIControlState)state{
    for (int i = 0;i<[self.buttons count];i++) {
        UIButton * b = (UIButton *)[self.buttons objectAtIndex:i];
        [b setTitleColor:textColor forState:state];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color forWidth:(CGFloat)width {
    CGRect rect = CGRectMake(0.0f, 0.0f, width, self.bounds.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    for (int i = 0;i<[self.buttons count];i++) {
        UIImage * image = [self imageWithColor:color forWidth:self.bounds.size.width / self.numberOfSegments];
        [self setBackgroundImage:image forState:state andIndex:i];
    }
}

-(void) setTitleShadowColor:(UIColor*)shadowColor forState:(UIControlState)state{
    for (int i = 0;i<[self.buttons count];i++) {
        UIButton * b = (UIButton *)[self.buttons objectAtIndex:i];
        [b.titleLabel setShadowOffset:CGSizeMake(0, 1)];
        [b setTitleShadowColor:shadowColor forState:state];
    }
}

- (void)setStretchableBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    for (int i = 0;i<[self.buttons count];i++) {
        UIButton * b = (UIButton *)[self.buttons objectAtIndex:i];
        UIImage *stretchedBackgroundImage = [image stretchableImageWithLeftCapWidth:image.size.width/2-1 topCapHeight:image.size.height/2];
        [b setBackgroundImage:stretchedBackgroundImage forState:state];
    }
}

@end
