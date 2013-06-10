//
//  ViewController.m
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "TCInterestsPickerViewController.h"

// Models
#import "TCInterestPickerItemModel.h"

// Categories
#import "UIColor+BMAddings.h"
#import "NSArray+BMAddings.h"

// Views
#import "TCInterestPickerItemCollectionViewCell.h"

@interface TCInterestsPickerViewController ()

@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *interests;

@end

@implementation TCInterestsPickerViewController

@synthesize collectionView = _collectionView;
@synthesize interests = _interests;
-(NSArray *)interests {
    if(!_interests) {
        _interests = [[NSArray alloc] initWithTitlesBackgroundColorsAndTitleColors:
                      @"Nature",[UIColor colorWithCommaSeparatedRGBString:@"219	126	80	"],[UIColor colorWithCommaSeparatedRGBString:@"60	58	55	"],
                      @"Sport",[UIColor colorWithCommaSeparatedRGBString:@"129	157	122	"],[UIColor colorWithCommaSeparatedRGBString:@"238	236	216	"],
                      @"Expos",[UIColor colorWithCommaSeparatedRGBString:@"245	232	145	"],[UIColor colorWithCommaSeparatedRGBString:@"57	57	56	"],
                      @"Concerts",[UIColor colorWithCommaSeparatedRGBString:@"101	119	147	"],[UIColor colorWithCommaSeparatedRGBString:@"238	236	216	"],
                      @"Cinéma",[UIColor colorWithCommaSeparatedRGBString:@"221	128	124	"],[UIColor colorWithCommaSeparatedRGBString:@"57	57	55	"],
                      @"Clubing",[UIColor colorWithCommaSeparatedRGBString:@"57	57	55	"],[UIColor colorWithCommaSeparatedRGBString:@"238	236	216	"],
                      @"Culture",[UIColor colorWithCommaSeparatedRGBString:@"173	223	221	"],[UIColor colorWithCommaSeparatedRGBString:@"57	57	55	"],
                      @"Detente",[UIColor colorWithCommaSeparatedRGBString:@"94	87	105	"],[UIColor colorWithCommaSeparatedRGBString:@"237	236	215	"],
                      nil];
    }
    return _interests;
}

#pragma mark Controller Lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfInterests];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCInterestPickerItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TCInterestPickerItemCollectionViewCell class]) forIndexPath:indexPath];
    if(cell) {
        cell.delegate = self;
    }
    
    TCInterestPickerItemModel *interest = [self interestAtIndex:indexPath.row];
    
    cell.frontColor = [interest backgroundColor];
    cell.titleColor = [interest titleColor];
    cell.title = [interest title];
    
    if([interest isOpen]) {
        [cell openCell];
    }
    else {
        [cell closeCell];
    }
    
    return cell;
}

#pragma mark - InterestsItemCollectionViewCellDelegate Methods
- (void)interestPickerItemCollectionViewCell:(TCInterestPickerItemCollectionViewCell *)cell frontViewHasBeenTapped:(UIView *)frontView {
    
    TCInterestPickerItemModel *interest = [self interestAtIndex:[self.collectionView indexPathForCell:cell].row];
    if (![cell isOpen]) {
        [cell openCellAnimated:^{
            interest.open = [cell isOpen];
        }];
    }
    else {
        [cell closeCellAnimated:^{
            interest.open = [cell isOpen];
        }];
    }
}

#pragma mark - InterestsItemCollectionViewDelegate Methods
- (IBAction)backButtonTapped:(UIButton *)button {
    if([self.delegate respondsToSelector:@selector(interestsPickerViewControllerDidPushBack:)]) {
        [self.delegate interestsPickerViewControllerDidPushBack:self];
    }
}

#pragma mark - Interects Collection Methods
- (TCInterestPickerItemModel *)interestAtIndex:(NSUInteger)index {
    return [self.interests objectAtIndex:index];
}
- (NSUInteger)numberOfInterests {
    return [self.interests count];
}

@end
