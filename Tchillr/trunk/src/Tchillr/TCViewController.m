//
//  TCViewController.m
//  Tchillr
//
//  Created by Jad on 19/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCViewController.h"
#import "TCConstants.h"

@interface TCViewController ()

@end

@implementation TCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView * backgroungImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backgroungImageView setImage:kDefaultImage];
    [backgroungImageView setAlpha:0.8];
    [self.view insertSubview:backgroungImageView atIndex:0];
}

@end
