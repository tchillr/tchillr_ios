//
//  TCCalloutAnnotationView.m
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCCalloutAnnotationView.h"
#import "TCCalloutAnnotation.h"
#import "UIColor+Tchillr.h"

@interface TCCalloutAnnotationView()

@property (nonatomic, retain) UILabel * titleLabel;
@property (nonatomic, retain) UIButton * calloutButton;

@end

@implementation TCCalloutAnnotationView

@synthesize title = _title;
@synthesize delegate = _delegate;
@synthesize calloutButton = _calloutButton;
@synthesize titleLabel = _titleLabel;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 135, 80);
        UIView * backgroundBlackView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 135, 30)];
        backgroundBlackView.backgroundColor = [UIColor tcBlack];
        [self addSubview:backgroundBlackView];
        
        //self.backgroundColor = [UIColor redColor];
       
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 105, 30)];
        _titleLabel.textColor = [UIColor tcWhite];

        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14]];
        [_titleLabel setNumberOfLines:2];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        _calloutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _calloutButton.frame = CGRectMake(110, 5, 25, 30);
        _calloutButton.backgroundColor = [UIColor clearColor];
        [_calloutButton setBackgroundImage: [UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
        [self addSubview:_calloutButton];
        [_calloutButton addTarget:self action:@selector(calloutAnnotationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.text = self.title;
}

#pragma mark - Button clicked
- (void)calloutAnnotationButtonClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(calloutAnnotationButtonClicked)]) {
        [self.delegate calloutAnnotationButtonClicked];
    }
}

@end
