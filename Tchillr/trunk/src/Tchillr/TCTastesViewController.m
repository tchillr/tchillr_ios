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

#define kOpenedCollectionCellWidth 174

@interface TCTastesViewController ()

- (IBAction)validateTastes:(id)sender;
@end

@implementation TCTastesViewController

#pragma mark View Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
	}
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Tastes Validation
- (IBAction)validateTastes:(id)sender {
	[self.delegate tastesViewControllerDidFinishEditing:self];
}

#pragma mark UICollectionViewDelegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if([collectionView cellForItemAtIndexPath:indexPath].selected) {
        return CGSizeMake(kOpenedCollectionCellWidth, collectionView.bounds.size.height);
    }
    else {
        return CGSizeMake(((UICollectionViewFlowLayout *)collectionViewLayout).itemSize.width, collectionView.bounds.size.height);
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCTastesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TCTastesCollectionViewCell class]) forIndexPath:indexPath];

	switch (indexPath.row) {
		case 0:
			cell.titleLabel.text = @"Cinéma";
			cell.backgroundColor = [[UIColor tcColorsWithAlpha:0.95] objectAtIndex:2];
			break;
		case 1:
			cell.titleLabel.text = @"Musique";
			cell.backgroundColor = [[UIColor tcColorsWithAlpha:0.95] objectAtIndex:0];
			break;
		case 2:
			cell.titleLabel.text = @"Nature";
			cell.backgroundColor = [[UIColor tcColorsWithAlpha:0.95] objectAtIndex:5];
			break;
		case 3:
			cell.titleLabel.text = @"Expos";
			cell.backgroundColor = [[UIColor tcColorsWithAlpha:0.95] objectAtIndex:4];
			break;
	}
	
	cell.titleLabel.text = [cell.titleLabel.text uppercaseString];
	
	
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if([collectionView cellForItemAtIndexPath:indexPath].selected) {
        [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    }
}

@end
