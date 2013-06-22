//
//  TCMusicViewController.m
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCThemesViewController.h"
#import "TCActivityTableViewCell.h"
#import "TCThemeViewController.h"
#import "TCTheme.h"
#import "TCServerClient.h"

@interface TCThemesViewController ()

@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSArray * themes;

@end

@implementation TCThemesViewController

@synthesize tableView = _tableView;
@synthesize themes = _themes;

#pragma mark LifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [[TCServerClient sharedTchillrServerClient] startThemesRequestWithSuccess:^(NSArray *themesArray) {
        self.themes = themesArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    [self setTitle:@"Thèmes"];    
}

#pragma mark Activity Access

- (NSUInteger)numberOfThemes {
    return [self.themes count];
}

- (TCTheme *)themeAtIndex:(NSUInteger)index {
    return (TCTheme*)[self.themes objectAtIndex:index];
}

#pragma mark - UITableViewDataSource / Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfThemes];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    NSString * string = [self themeAtIndex:indexPath.row].title;
    [cell.textLabel setText:string];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell * cell = (UITableViewCell *)sender;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    TCTheme * theme = [self.themes objectAtIndex:indexPath.row];
    TCThemeViewController * themeViewController = (TCThemeViewController *) segue.destinationViewController;
    [themeViewController setThemeString:theme.title];
}

@end
