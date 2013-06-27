//
//  TCAddressTableViewCell.h
//  Tchillr
//
//  Created by Jad on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCActivityDetailResizableCell.h"

@interface TCAddressTableViewCell : TCActivityDetailResizableCell

@property (nonatomic, weak) IBOutlet UILabel * placeLabel;
@property (nonatomic, weak) IBOutlet UILabel * addressLabel;

@end
