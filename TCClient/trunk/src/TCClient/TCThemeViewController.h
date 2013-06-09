//
//  TCThemeViewController.h
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTheme.h"
#import "TCTagTableViewCell.h"

@interface TCThemeViewController : UIViewController<TCTagTableViewCellDelegate>

@property (nonatomic, assign) TCThemeType themeType;

@end
