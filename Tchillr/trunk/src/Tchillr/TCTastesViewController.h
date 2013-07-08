//
//  TCTastesViewController.h
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCViewController.h"
#import "TCThemesModelDelegate.h"
#import "TCTastesCollectionViewCell.h"

@class TCTastesViewController;

@protocol TCTastesViewControllerDelegate <NSObject>

- (void)tastesViewControllerDidFinishEditing:(TCTastesViewController *)tastesViewController;

@end

@interface TCTastesViewController : TCViewController <TCThemesModelDelegate, TCTastesCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet id<TCTastesViewControllerDelegate> delegate;

@end
