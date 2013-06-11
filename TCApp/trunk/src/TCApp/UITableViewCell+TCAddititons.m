//
//  UITableViewCell+TCAddititons.m
//  TCApp
//
//  Created by Jad on 11/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "UITableViewCell+TCAddititons.h"

@implementation UITableViewCell (TCAddititons)

- (void)customizeAsLightWhiteCell{
    [self.contentView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:238.0/255 blue:234.0/255 alpha:1]];
}

@end
