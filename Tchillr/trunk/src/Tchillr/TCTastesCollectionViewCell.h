//
//  TCTastesCollectionViewCell.h
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCTastesCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign, nonatomic) IBOutlet UITableView *tastesTableView;

@end
