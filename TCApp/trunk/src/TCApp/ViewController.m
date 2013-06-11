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
#import "TCActivity.h"
#import "TCTchillrServerClient.h"
#import "TCActivityTableViewCell.h"
#import "TCActivityDetailViewController.h"
#import "UITableViewCell+TCAddititons.h"
#import "TCConstants.h"

@interface ViewController ()

@property (nonatomic, assign, getter = isInterestsPickerHasBeenShown) BOOL interestsPickerHasBeenShown;
@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSArray * activities;

@end

@implementation ViewController

@synthesize tableView = _tableView;
@synthesize activities = _activities;
- (NSArray *)activities {
    if (_activities == nil) {
        _activities = [[NSArray alloc] init];
    }
    return _activities;
}

#pragma mark Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_PROGRESS_HUD object:self.view];
    [[TCTchillrServerClient sharedTchillrServerClient] startUserActivitiesRequestWithSuccess:^(NSArray *activitiesArray) {
        self.activities = activitiesArray;
        [self.tableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:self.view];
    } offset:0 limit:1000];
    [self setTitle:@"Suggestions"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidAppear:(BOOL)animated {
    if(!self.isInterestsPickerHasBeenShown) {
        [self performSegueWithIdentifier:NSStringFromClass([TCInterestsPickerViewController class]) sender:nil];
    }
}

#pragma mark Activity Access

- (NSUInteger)numberOfActivities {
    return [self.activities count];
}

- (TCActivity *)activityAtIndex:(NSUInteger)index {
    return (TCActivity*)[self.activities objectAtIndex:index];
}

#pragma mark - UITableViewDataSource / Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfActivities];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityTableViewCellIdentifier"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell customizeAsLightWhiteCell];
    TCActivity * activity = [self activityAtIndex:indexPath.row];
    [cell.activityNameLabel setText:activity.name];
    [cell.activityShortDescriptionLabel setText:activity.shortDescription];
    [cell.activityNextOccurenceLabel setText:activity.formattedOccurence];
    BOOL activityHasTags = [activity hasTags];
    [cell.activityContextualTags setHidden:!activityHasTags];
    [cell.activityContextualTags setText:[activity formattedContextualTags]];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:NSStringFromClass([TCInterestsPickerViewController class])])
	{
		TCInterestsPickerViewController *interestsPickerViewController = segue.destinationViewController;
		interestsPickerViewController.delegate = self;
        
        self.interestsPickerHasBeenShown = YES;
	}
    else if ([segue.identifier isEqualToString:NSStringFromClass([TCActivityDetailViewController class])]) {
        TCActivityTableViewCell * cellTouched = (TCActivityTableViewCell *)sender;
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cellTouched];
        TCActivity * activity = [self activityAtIndex:indexPath.row];
        TCActivityDetailViewController * activityDetailViewController = (TCActivityDetailViewController *) segue.destinationViewController;
        [activityDetailViewController setActivity:activity];
    }
}

-(void)interestsPickerViewControllerDidPushBack:(TCInterestsPickerViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
