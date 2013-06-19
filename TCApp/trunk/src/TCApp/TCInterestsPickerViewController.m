//
//  ViewController.m
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "TCInterestsPickerViewController.h"
#import "TCColors.h"
#import "TCColor.h"
#import "TCTchillrServerClient.h"

// Models
#import "TCTheme.h"
#import "TCTag.h"

// Views
#import "TCInterestPickerItemCollectionViewCell.h"

// Constants
#import "TCConstants.h"

@interface TCInterestsPickerViewController ()

@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *themes;
@property (nonatomic, retain) NSArray *interestsIds;

@end

@implementation TCInterestsPickerViewController

@synthesize collectionView = _collectionView;
@synthesize themes = _themes;

#pragma mark Controller Lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_PROGRESS_HUD object:self.view];
    // Call to themes/theme tags
    [[TCTchillrServerClient sharedTchillrServerClient] startThemesRequestWithSuccess:^(NSArray *themeTagsArray) {
        self.themes = themeTagsArray;
        // Call to user interests ids
        [[TCTchillrServerClient sharedTchillrServerClient] startInterestsRequestWithSuccess:^(NSArray *interestsArray) {
            self.interestsIds = interestsArray;
            [self.collectionView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:self.view];
        } failure:^(NSError *error) {
            NSLog(@"%@", [error description]);
            [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:self.view];
        }];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfThemes];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCInterestPickerItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TCInterestPickerItemCollectionViewCell class]) forIndexPath:indexPath];
    
    if(cell) {
    }
    
    cell.delegate = self;
    cell.modelDelegate = self;
    
    TCTheme * theme = [self themeAtIndex:indexPath.row];
    
    cell.frontColor = ((TCColor *)[TCColors colorAtIndex:indexPath.row]).backgroundColor;
    cell.titleColor = ((TCColor *)[TCColors colorAtIndex:indexPath.row]).titleColor;
    cell.title = theme.title;
    [cell.collectionView reloadData];
    
    if([theme isOpen]) {
        [cell openCell];
    }
    else {
        [cell closeCell];
    }
    
    return cell;
}

#pragma mark - InterestsItemCollectionViewCellDelegate Methods
- (void)interestPickerItemCollectionViewCell:(TCInterestPickerItemCollectionViewCell *)cell frontViewHasBeenTapped:(UIView *)frontView {
    TCTheme *theme = [self themeAtIndex:[self.collectionView indexPathForCell:cell].row];
    if (![cell isOpen]) {
        [cell openCellAnimated:^{
            theme.open = [cell isOpen];
        }];
    }
    else {
        [cell closeCellAnimated:^{
            theme.open = [cell isOpen];
        }];
    }
}

- (NSUInteger)interestPickerItemCollectionViewCellNumberOfTags:(TCInterestPickerItemCollectionViewCell *)cell{
    TCTheme *theme = [self themeAtIndex:[self.collectionView indexPathForCell:cell].row];
    return [theme.tags count];
}

- (TCTag *)interestPickerItemCollectionViewCell:(TCInterestPickerItemCollectionViewCell *)cell tagForItemAtIndex:(NSUInteger)index{
    TCTheme *theme = [self themeAtIndex:[self.collectionView indexPathForCell:cell].row];
    return (TCTag *)[theme.tags objectAtIndex:index];
}

#pragma mark - InterestsItemCollectionViewDelegate Methods
- (IBAction)backButtonTapped:(UIButton *)button {
    if([self.delegate respondsToSelector:@selector(interestsPickerViewControllerDidPushBack:)]) {
        [self.delegate interestsPickerViewControllerDidPushBack:self];
    }
}

#pragma mark - Themes Collection Methods
- (TCTheme *)themeAtIndex:(NSUInteger)index {
    return [self.themes objectAtIndex:index];
}
- (NSUInteger)numberOfThemes {
    return [self.themes count];
}

#pragma mark - TCInterestModelDelegate
- (NSArray *)userInterests{
    return self.interestsIds;
}

#pragma mark TCTagTableViewCellDelegate
- (void)interestItemCollectionViewCell:(TCInterestPickerItemCollectionViewCell *)cell triggeredTapForTagAtIndex:(NSInteger)index {
    
#warning Only music theme for now
    TCTheme * theme = [self themeAtIndex:[self.collectionView indexPathForCell:cell].row];
    TCTag * tag = [theme tagAtIndex:index];
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_PROGRESS_HUD object:cell];
    [[TCTchillrServerClient sharedTchillrServerClient] startUpdateInterestRequestWithIdentifier:tag.identifier success:^(NSArray * interestsArray) {
        self.interestsIds = interestsArray;
        [cell.collectionView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:cell];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:cell];
    }];
    
}

@end
