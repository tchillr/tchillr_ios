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
#import "TCSelectedTagsView.h"
#import "MBProgressHUD.h"
// Categories
#import "UIColor+Tchillr.h"

// Models
#import "TCServerClient.h"
#import "TCTag.h"
#import "TCUserInterests.h"

#import "TCConstants.h"


#define kOpenedCollectionCellWidth 174

@interface TCTastesViewController ()

@property (nonatomic, retain) NSMutableArray *openedCellsIndex;
@property (nonatomic, retain) NSArray * themes;
@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *selectedTagsIdentifiers;

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

@synthesize selectedTagsIdentifiers = _selectedTagsIdentifiers;
- (NSMutableArray *)selectedTagsIdentifiers {
    if(!_selectedTagsIdentifiers) {
        _selectedTagsIdentifiers = [[NSMutableArray alloc] init];
    }
    return _selectedTagsIdentifiers;
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
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_PROGRESS_HUD object:self.view];
    [[TCServerClient sharedTchillrServerClient] startThemesRequestWithSuccess:^(NSArray *themeTagsArray) {
        self.themes = themeTagsArray;
        [[TCServerClient sharedTchillrServerClient] startInterestsRequestWithSuccess:^(NSArray *interestsArray) {
            for (TCTag *tag in interestsArray) {
                [self.selectedTagsIdentifiers addObject:tag.identifier];
            }
            [TCUserInterests sharedTchillrUserInterests].interests = interestsArray;
            [self.collectionView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:self.view];
        } failure:^(NSError *error) {
            NSLog(@"%@",[error description]);
            [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:self.view];
        }];
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:self.view];
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
    if ([self.selectedTagsIdentifiers count] == 0) {
        [self.delegate tastesViewControllerDidFinishEditing:self];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOW_PROGRESS_HUD object:self.view];
        [[TCServerClient sharedTchillrServerClient] startRefreshInterestRequestWithInterestsList:self.selectedTagsIdentifiers
                                                                                         success:^(NSArray *interestsArray) {
                                                                                             [TCUserInterests sharedTchillrUserInterests].interests = interestsArray;
                                                                                             [self.delegate tastesViewControllerDidFinishEditing:self];
                                                                                             [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:self.view];
                                                                                         }
                                                                                         failure:^(NSError *error) {
                                                                                             NSString * message = [NSString stringWithFormat:NSLocalizedString(@"TASTES_PICKER_UPDATE_INTERESTS_FAILURE", nil)];
                                                                                             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Tchillr" message:message delegate:self cancelButtonTitle:@"Mince !" otherButtonTitles:nil];
                                                                                             [alert show];
                                                                                             [[NSNotificationCenter defaultCenter] postNotificationName:HIDE_PROGRESS_HUD object:self.view];
                                                                                         }];
    }
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
    
    TCTheme *theme = [self themeAtIndex:indexPath.row];
    
    cell.themesModelDelegate = self;
    cell.themeIndex = indexPath.row;
    cell.backgroundColor = [[UIColor tcColorsWithAlpha:0.90] objectAtIndex:indexPath.row];
    cell.titleLabel.text = [theme.title uppercaseString];
    cell.open = [self.openedCellsIndex containsObject:[NSNumber numberWithInteger:indexPath.row]];
    cell.delegate = self;
    cell.selectedTagsIdentifiers = self.selectedTagsIdentifiers;
    
    NSIndexSet *setOfTags =[theme.tags indexesOfObjectsPassingTest:^BOOL(TCTag *tag, NSUInteger idx, BOOL *stop) {
        return [self.selectedTagsIdentifiers containsObject:tag.identifier];
    }];
    [cell.selectedTagsView setNumberOfSelectedTags:setOfTags.count];
    
    [cell.tastesTableView reloadData];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger openedCellIndex = [self.openedCellsIndex indexOfObjectPassingTest:^BOOL(NSNumber *index, NSUInteger idx, BOOL *stop) {
        return indexPath.row == index.integerValue;
    }];
    if(openedCellIndex == NSNotFound) {
        [self.openedCellsIndex addObject:[NSNumber numberWithInteger:indexPath.row]];
        [self performSelector:@selector(repositionCellAtIndexPath:) withObject:indexPath afterDelay:0.100f];
    }
    else {
        [self.openedCellsIndex removeObject:[NSNumber numberWithInteger:indexPath.row]];
    }
    
    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

#pragma mark TCTastesCollectionViewCellDelegate methods

- (void)tastesCollectionViewCell:(TCTastesCollectionViewCell *)cell didSelectTagAtIndex:(NSInteger)index {
    TCTheme *theme = [self themeAtIndex:[self.collectionView indexPathForCell:cell].row];
    NSNumber *tagId = [theme tagAtIndex:index].identifier;
    
    BOOL isTagAlreadySelected = [self.selectedTagsIdentifiers containsObject:tagId];
    if(isTagAlreadySelected) {
        [self.selectedTagsIdentifiers removeObject:tagId];
    }
    else {
        [self.selectedTagsIdentifiers addObject:tagId];
    }
}

#pragma mark - Usefull
- (void)repositionCellAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
