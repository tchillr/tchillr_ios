//
//  TCFirstViewController.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTchillrServerClient.h"
#import "TCActivitiesViewController.h"
#import "TCActivityDetailViewController.h"
#import "TCActivityTableViewCell.h"
#import "TCActivity.h"
#import "AFJSonRequestOperation.h"

#define kTchillrActivitiesURL @"http://tchillr.azurewebsites.net/TchillrREST/StaticActivities"

@interface TCActivitiesViewController ()

@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSMutableArray * activities;

@end

@implementation TCActivitiesViewController

@synthesize tableView = _tableView;
@synthesize activities = _activities;
- (NSMutableArray *)activities {
    if (_activities == nil) {
        _activities = [[NSMutableArray alloc] init];
    }
    return _activities;
}

#pragma mark Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[TCTchillrServerClient sharedTchillrServerClient] startActivitiesRequest:self.activities success:^(BOOL activitiesRequestSucceeded) {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    } offset:0 limit:1000];
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
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ (%@)",activity.name,activity.identifier]];
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
