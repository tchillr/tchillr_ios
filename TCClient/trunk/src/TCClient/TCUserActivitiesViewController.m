//
//  TCUserActivitiesViewController.m
//  TCClient
//
//  Created by Jad on 10/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCUserActivitiesViewController.h"
#import "TCTchillrServerClient.h"
#import "TCActivityDetailViewController.h"
#import "TCActivityTableViewCell.h"
#import "TCActivity.h"
#import "AFJSONRequestOperation.h"

@interface TCUserActivitiesViewController ()

@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSArray * activities;

@end

@implementation TCUserActivitiesViewController

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
    [[TCTchillrServerClient sharedTchillrServerClient] startUserActivitiesRequestWithSuccess:^(NSArray *activitiesArray) {
        self.activities = activitiesArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    } offset:0 limit:1000];
    [self setTitle:@"Suggestions"];
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
    TCActivity * activity = [self activityAtIndex:indexPath.row];
    [cell.activityNameLabel setText:activity.name];
    [cell.activityFullAdressLabel setText:activity.fullAdress];
    [cell.activityShortDescriptionLabel setText:activity.shortDescription];
    [cell.activityNextOccurenceLabel setText:activity.formattedOccurence];
    BOOL activityHasTags = [activity hasTags];
    [cell.activityContextualTagsView setHidden:!activityHasTags];
    if (activityHasTags) {
        [cell.activityContextualTags setText:[activity formattedContextualTags]];
    }
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TCActivityTableViewCell * cellTouched = (TCActivityTableViewCell *)sender;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cellTouched];
    TCActivity * activity = [self activityAtIndex:indexPath.row];
    TCActivityDetailViewController * activityDetailViewController = (TCActivityDetailViewController *) segue.destinationViewController;
    [activityDetailViewController setActivity:activity];
}

@end
