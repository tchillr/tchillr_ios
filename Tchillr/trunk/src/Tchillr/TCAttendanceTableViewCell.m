//
//  TCAttendanceTableViewCell.m
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCAttendanceTableViewCell.h"
#import "UIColor+Tchillr.h"
#import "TCServerClient.h"

@implementation TCAttendanceTableViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setUpSegmentedControl:self.segmentedControl];
}


- (void)setUpSegmentedControl:(JASegmentedControl*)control {
    control.numberOfSegments = 3;
    // Set the titles for normal state
    [control setTitles:[NSArray arrayWithObjects:@"Oui", @"Peut être", @"Non", nil] forState:UIControlStateNormal&UIControlStateSelected];
    [control setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24]];
    // Set the title appearance - Normal
    [control setTitleColor:[UIColor tcBlack] forState:UIControlStateNormal];
    [control setTitleColor:[UIColor tcWhite] forState:UIControlStateSelected];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.segmentedControl setBackgroundColor:[UIColor tcWhite] forState:UIControlStateNormal];
    [self.segmentedControl setBackgroundColor:[UIColor tcBlack] forState:UIControlStateSelected];
}

@end
