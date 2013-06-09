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

@interface TCThemesViewController ()

@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSArray * themes;

@end

@implementation TCThemesViewController

@synthesize tableView = _tableView;

@synthesize themes = _themes;
- (NSArray *)themes{
    if (_themes == nil) {
        _themes = [NSArray arrayWithObjects:@"Musique",@"Cinéma",@"Expos",@"Nocturnes",@"Nature",nil];
    }
    return _themes;
}

#pragma mark Activity Access

- (NSUInteger)numberOfThemes {
    return [self.themes count];
}

- (NSString *)themeAtIndex:(NSUInteger)index {
    return (NSString*)[self.themes objectAtIndex:index];
}

#pragma mark - UITableViewDataSource / Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfThemes];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    [cell.textLabel setText:[self themeAtIndex:indexPath.row]];
    return cell;
}

#pragma mark Theme type for row
- (TCThemeType)themeForRowAtIndexpath:(NSIndexPath*)indexPath {
    TCThemeType type;
    switch (indexPath.row) {
        case 0:
            type = TCThemeTypeMusic;
            break;
        case 1:
            type = TCTHemeTypeCinema;
            break;
        case 2:
            type = TCThemeTypeExpo;
            break;
        case 3:
            type = TCThemeTypeNocturne;
            break;
        case 4:
            type = TCThemeTypeNature;
            break;
        default:
            type = TCThemeTypeNone;
            break;
    }
    return type;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell * cell = (UITableViewCell *)sender;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    TCThemeType themeType = [self themeForRowAtIndexpath:indexPath];
    TCThemeViewController * themeViewController = (TCThemeViewController *) segue.destinationViewController;
    [themeViewController setThemeType:themeType];
}

@end
