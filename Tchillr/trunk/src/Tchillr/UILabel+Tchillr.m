//
//  UILabel+Tchillr.m
//  Tchillr
//
//  Created by Jad on 27/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "UILabel+Tchillr.h"

@implementation UILabel (Tchillr)

- (CGSize) idealSize {
    return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, 10000)];
}

@end
