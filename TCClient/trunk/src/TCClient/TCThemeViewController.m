//
//  TCThemeViewController.m
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCThemeViewController.h"
#import "TCTchillrServerClient.h"
#import "TCTheme.h"
#import "TCTag.h"
#import "TCTagTableViewCell.h"

@interface TCThemeViewController ()

@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSArray * tags;
@property (nonatomic, retain) NSArray * interestsIds;

@end

@implementation TCThemeViewController

@synthesize tableView = _tableView;

#pragma mark LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[TCTchillrServerClient sharedTchillrServerClient] startTagsRequestForTheme:self.themeString success:^(NSArray *themeTagsArray) {
        self.tags = themeTagsArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", [error description]);
    }];
    
    [[TCTchillrServerClient sharedTchillrServerClient] startInterestsRequestWithSuccess:^(NSArray *interestsArray) {
        self.interestsIds = interestsArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", [error description]);
    }];
}

#pragma mark Tag Access
- (NSUInteger)numberOfTags {
    return [self.tags count];
}

- (TCTag *)tagAtIndex:(NSUInteger)index {
    return (TCTag*)[self.tags objectAtIndex:index];
}

#pragma mark - UITableViewDataSource / Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfTags];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagTableViewCellIdentifier"];
    TCTag * tag = [self tagAtIndex:indexPath.row];
    [cell setDelegate:self],
    [cell.tagView.textLabel setText:tag.title];
    
    NSUInteger index = [self.interestsIds indexOfObjectPassingTest:^BOOL(NSNumber * interestId, NSUInteger idx, BOOL *stop) {
        return [tag.identifier isEqualToNumber:interestId];
    }];
    
    [cell.tagView setUserInterest:(index != NSNotFound)];
    return cell;
}

#pragma mark TCTagTableViewCellDelegate
- (void)tagTableViewCellDidTapInterest:(TCTagTableViewCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    TCTag * tag = [self tagAtIndex:indexPath.row];
    [[TCTchillrServerClient sharedTchillrServerClient] startUpdateInterestRequestWithIdentifier:tag.identifier success:^(NSArray * interestsArray) {
        self.interestsIds = interestsArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];    
}

@end
