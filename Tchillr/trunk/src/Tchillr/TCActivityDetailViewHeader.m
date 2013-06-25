//
//  TCActivityDetailViewHeader.m
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCActivityDetailViewHeader.h"
#import "TCTriangleView.h"

@interface TCActivityDetailViewHeader()

@property (nonatomic, retain) IBOutlet TCTriangleView * triangleView;


@end

@implementation TCActivityDetailViewHeader



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
