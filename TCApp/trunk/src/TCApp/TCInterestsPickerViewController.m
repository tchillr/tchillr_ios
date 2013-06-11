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
#import "TCInterestPickerItemModel.h"
#import "TCTheme.h"

// Categories
#import "UIColor+BMAddings.h"
#import "NSArray+BMAddings.h"

// Views
#import "TCInterestPickerItemCollectionViewCell.h"

@interface TCInterestsPickerViewController ()

@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *themes;


@end

@implementation TCInterestsPickerViewController

@synthesize collectionView = _collectionView;
@synthesize themes = _themes;

#pragma mark Controller Lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [[TCTchillrServerClient sharedTchillrServerClient] startThemesRequestWithSuccess:^(NSArray *themeTagsArray) {
        self.themes = themeTagsArray;
        [self.collectionView reloadData];
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
        cell.delegate = self;
    }
    
    TCTheme * theme = [self themeAtIndex:indexPath.row];
    
    cell.frontColor = ((TCColor *)[TCColors colorAtIndex:indexPath.row]).backgroundColor;
    cell.titleColor = ((TCColor *)[TCColors colorAtIndex:indexPath.row]).titleColor;
    cell.title = theme.title;
    
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

@end
