//
//  UICollectionViewCell+Tchillr.m
//  Tchillr
//
//  Created by Jad on 28/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "UICollectionViewCell+Tchillr.h"
#import "UIColor+Tchillr.h"
#import "TCActivity.h"

@implementation UICollectionViewCell (Tchillr)

- (void)customizeWithStyle:(TCActivityColorStyle)style{
    [self.contentView setBackgroundColor:[UIColor tcColorWithStyle:style]];
}

@end
