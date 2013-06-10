//
//  ViewController.m
//  TCApp
//
//  Created by Meski Badr on 10/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

//Controllers
#import "ViewController.h"
#import "TCInterestsPickerViewController.h"

@interface ViewController ()

@property (nonatomic, assign, getter = isInterestsPickerHasBeenShown) BOOL interestsPickerHasBeenShown;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    if(!self.isInterestsPickerHasBeenShown) {
        [self performSegueWithIdentifier:NSStringFromClass([TCInterestsPickerViewController class]) sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:NSStringFromClass([TCInterestsPickerViewController class])])
	{
		TCInterestsPickerViewController *interestsPickerViewController = segue.destinationViewController;
		interestsPickerViewController.delegate = self;
        
        self.interestsPickerHasBeenShown = YES;
	}
}

-(void)interestsPickerViewControllerDidPushBack:(TCInterestsPickerViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
