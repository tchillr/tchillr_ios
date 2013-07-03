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
@property (nonatomic, retain) UIImageView * arrowImageView;

@end

@implementation TCCalloutAnnotationView

@synthesize title = _title;
@synthesize arrowImageView = _arrowImageView;
@synthesize titleLabel = _titleLabel;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 135, 80);
        UIView * backgroundBlackView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 135, 30)];
        backgroundBlackView.backgroundColor = [UIColor tcBlack];
        [self addSubview:backgroundBlackView];
              
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 105, 30)];
        _titleLabel.textColor = [UIColor tcWhite];

        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14]];
        [_titleLabel setNumberOfLines:2];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
                                
        _arrowImageView.frame = CGRectMake(110, 5, 25, 30);
        _arrowImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_arrowImageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.text = self.title;
}

@end
