//
//  TCSecondViewController.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCCategoriesViewController.h"
#import "TCCategoryTableViewCell.h"
#import "TCTchillrServerClient.h"
#import "TCCategory.h"

@interface TCCategoriesViewController ()

@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSMutableArray * categories;

@end

@implementation TCCategoriesViewController

@synthesize tableView = _tableView;

@synthesize categories = _categories;
- (NSMutableArray *)categories {
    if (_categories == nil) {
        _categories = [[NSMutableArray alloc] init];
    }
    return _categories;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[TCTchillrServerClient sharedTchillrServerClient] startCategoriesRequest:self.categories success:^(BOOL categoriesRequestSucceeded) {
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];}

#pragma mark Category Access

- (NSUInteger)numberOfCategories {
    return [self.categories count];
}

- (TCCategory *)categoryAtIndex:(NSUInteger)index {
    return (TCCategory*)[self.categories objectAtIndex:index];
}

#pragma mark - UITableViewDataSource / Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfCategories];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCellIdentifier"];
    TCCategory * category = [self categoryAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ (%@)",category.name,category.identifier]];
    return cell;
}


@end
