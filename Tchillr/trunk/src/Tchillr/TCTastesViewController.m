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
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCTastesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TCTastesCollectionViewCell class]) forIndexPath:indexPath];

	TCColorStyle colorStyle;
	switch (indexPath.row) {
		case 0:
			cell.titleLabel.text = @"Cinéma";
			colorStyle = TCColorStyleCinema;
			break;
		case 1:
			cell.titleLabel.text = @"Musique";
			colorStyle = TCColorStyleMusic;
			break;
		case 2:
			cell.titleLabel.text = @"Nature";
			colorStyle = TCColorStyleNature;
			break;
		case 3:
			cell.titleLabel.text = @"Expos";
			colorStyle = TCColorStyleExpo;
			break;
		case 4:
			cell.titleLabel.text = @"Expos";
			colorStyle = TCColorStyleExpo;
			break;
		case 5:
			cell.titleLabel.text = @"Expos";
			colorStyle = TCColorStyleExpo;
			break;
		case 6:
			cell.titleLabel.text = @"Expos";
			colorStyle = TCColorStyleExpo;
			break;
		case 7:
			cell.titleLabel.text = @"Expos";
			colorStyle = TCColorStyleExpo;
			break;
	}
	
	cell.backgroundColor = [UIColor tcColorWithStyle:TCColorStyleCinema alpha:0.95];
	
    return cell;
}

@end
