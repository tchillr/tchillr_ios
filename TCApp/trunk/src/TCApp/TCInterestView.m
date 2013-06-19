//
//  TCInterestView.m
//  Tchillr
//
//  Created by Jad on 18/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "TCInterestView.h"
#import "TCConstants.h"

@interface TCInterestView()

@property (nonatomic, retain) UIImageView * heartImageView;
@property (nonatomic, retain) UILabel * interestTitleLabel;
@property (nonatomic, retain) NSString * title;


@end

@implementation TCInterestView
@synthesize selected = _selected;
- (void)setSelected:(BOOL)selected{
    if (_selected != selected) {
        _selected = selected;
        [self setNeedsLayout];
    }
}

@synthesize heartImageView = _heartImageView;
- (UIImageView *)heartImageView{
    if (_heartImageView == nil) {
        _heartImageView = [[UIImageView alloc] initWithImage:(self.selected) ? kHeartImageSelected : kHeartImage];
        [self addSubview:_heartImageView];
    }
    return _heartImageView;
}

@synthesize interestTitleLabel = _interestTitleLabel;
- (UILabel *)interestTitleLabel{
    if (_interestTitleLabel == nil) {
        _interestTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_interestTitleLabel];
    }
    return _interestTitleLabel;
}

#pragma mark - Lifecycle
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        [self setup];
    }
    return self;
}

- (void) setup{
    [self setBackgroundColor:[UIColor colorWithRed:54.0/255 green:54.0/255 blue:52.0/255 alpha:1]];
    [self.interestTitleLabel setBackgroundColor:[UIColor clearColor]];
    [self.interestTitleLabel setTextColor:[UIColor colorWithRed:240.0/255 green:238.0/255 blue:234.0/255 alpha:1]];
    [self.interestTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:28.0]];
    [self.interestTitleLabel setText:self.title];
    [self.heartImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOccured:)];
    [self.heartImageView addGestureRecognizer:tapGestureRecognizer];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.interestTitleLabel setFrame:CGRectMake(20.0, 0, 265.0, self.frame.size.height)];
    [self.heartImageView setFrame:CGRectMake(293, 9, 18, 16)];
    [self.heartImageView setImage:(self.selected) ? kHeartImageSelected : kHeartImage];
}

- (void)tapOccured:(UITapGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(userDidTapInterestView:atIndex:)]) {
            self.selected = !self.selected;
            
            //[self.delegate userDidTapInterestView:self atIndex:0];
        }
    }
}

@end
