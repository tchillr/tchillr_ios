//
//  PWScrollableSegmentedControl.m
//  JASegmentedControlDemo
//
//  Created by Jad Abi-Abdallah on 04/12/12.
//  Copyright (c) 2012 Inertia. All rights reserved.
//

#import "JAScrollableSegmentedControl.h"
#import "JASegmentedControl.h"

@implementation JAScrollableSegmentedControl

@synthesize segmentedControl = _segmentedControl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)refreshContentSize{
    CGSize contentSize = [self.segmentedControl contentSize];
    [self setContentSize:contentSize];
    NSLog(@"Content size for scroll view %@",NSStringFromCGSize(self.contentSize));
}

-(void)setup{
    self.segmentedControl = [[JASegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    [self.segmentedControl setPagingEnabled:YES];
    [self addSubview:self.segmentedControl];
    [self setPagingEnabled:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

@end
