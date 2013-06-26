//
//  TCTastesViewController.h
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCViewController.h"

@class TCTastesViewController;
@protocol TCTastesViewControllerDelegate <NSObject>

- (void)tastesViewControllerDidFinishEditing:(TCTastesViewController *)tastesViewController;

@end

@interface TCTastesViewController : TCViewController

@property (weak, nonatomic) IBOutlet id<TCTastesViewControllerDelegate> delegate;

@end
