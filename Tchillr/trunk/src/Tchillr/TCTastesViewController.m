//
//  TCTastesViewController.m
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTastesViewController.h"

// Views & Controls
#import "TCTastesCollectionViewCell.h"

// Categories
#import "UIColor+Tchillr.h"

#import "TCServerClient.h"

#define kOpenedCollectionCellWidth 174

@interface TCTastesViewController ()

@property (nonatomic, retain) NSMutableArray *openedCellsIndex;
@property (nonatomic, retain) NSArray * themes;
@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;

- (IBAction)validateTastes:(id)sender;

@end

@implementation TCTastesViewController

@synthesize openedCellsIndex = _openedCellsIndex;
- (NSArray *)openedCellsIndex {
    if(!_openedCellsIndex) {
        _openedCellsIndex = [[NSMutableArray alloc] init];
    }
    return _openedCellsIndex;
}

#pragma mark View Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
	}
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TCServerClient sharedTchillrServerClient] startThemesRequestWithSuccess:^(NSArray *themeTagsArray) {
        self.themes = themeTagsArray;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ThemesAccess
-(TCTheme *)themeAtIndex:(NSInteger)index{
    return [self.themes objectAtIndex:index];
}

#pragma mark Tastes Validation
- (IBAction)validateTastes:(id)sender {
	[self.delegate tastesViewControllerDidFinishEditing:self];
}

#pragma mark UICollectionViewDelegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.themes count];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger openedCellIndex = [self.openedCellsIndex indexOfObjectPassingTest:^BOOL(NSNumber *index, NSUInteger idx, BOOL *stop) {
        return indexPath.row == index.integerValue;
    }];
    if(openedCellIndex == NSNotFound) {
        return CGSizeMake(((UICollectionViewFlowLayout *)collectionViewLayout).itemSize.width, collectionView.bounds.size.height);
    }
    else {
        return CGSizeMake(kOpenedCollectionCellWidth, collectionView.bounds.size.height);
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCTastesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TCTastesCollectionViewCell class]) forIndexPath:indexPath];
    cell.themesModelDelegate = self;
    cell.themeIndex = indexPath.row;
    cell.backgroundColor = [[UIColor tcColorsWithAlpha:0.95] objectAtIndex:indexPath.row];
    cell.titleLabel.text = [[self themeAtIndex:indexPath.row].title uppercaseString];
    cell.open = [self.openedCellsIndex containsObject:[NSNumber numberWithInteger:indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger openedCellIndex = [self.openedCellsIndex indexOfObjectPassingTest:^BOOL(NSNumber *index, NSUInteger idx, BOOL *stop) {
        return indexPath.row == index.integerValue;
    }];
    if(openedCellIndex == NSNotFound) {
        [self.openedCellsIndex addObject:[NSNumber numberWithInteger:indexPath.row]];
    }
    else {
        [self.openedCellsIndex removeObject:[NSNumber numberWithInteger:indexPath.row]];
    }
    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

@end
