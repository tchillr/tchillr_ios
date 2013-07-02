//
//  TCActivityDetailViewController.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "TCConstants.h"

// Controllers
#import "TCActivityDetailViewController.h"
#import "TCRouteViewController.h"

// Server Client
#import "TCServerClient.h"
// Categories
#import "UICollectionViewCell+Tchillr.h"
#import "UITableViewCell+Tchillr.h"
#import "UIColor+Tchillr.h"
// Views
#import "TCTriangleView.h"
#import "TCActivityDetailViewHeader.h"
// View Cells
#import "TCAddressTableViewCell.h"
#import "TCTagsTableViewCell.h"
#import "TCAttendanceTableViewCell.h"
#import "TCGalleryTableViewCell.h"
#import "TCDescriptionTableViewCell.h"
// Collection View Cells
#import "TCActivityTagsCollectionViewCell.h"
#import "TCActivityGalleryCollectionViewCell.h"
// Collection View tags
#define kTCActivityTagsCollectionViewTag 1000
#define kTCActivityGalleryCollectionViewTag 2000


// Model
#import "TCTag.h"
#import "TCMedia.h"

// TableView Rows
#define KNumberOfRows   5

#define KRowAddress     0
#define KRowTags        1
#define KRowAttendance  2
#define KRowGallery     3
#define KRowDescription 4

@interface TCActivityDetailViewController ()

@property (nonatomic, retain) TCActivityDetailViewHeader *activityHeaderView;
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic, retain) IBOutlet UIButton * backButton;
@property (nonatomic, retain) NSArray * interests;

@end

@implementation TCActivityDetailViewController

@synthesize activityHeaderView = _activityHeaderView;
@synthesize tableView = _tableView;


#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityHeaderView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TCActivityDetailViewHeader class]) owner:nil options:nil] objectAtIndex:0];
    [self.activityHeaderView.nameLabel setText:[self.activity.name uppercaseString]];
    [self.activityHeaderView.dayLabel setText:self.activity.formattedDay];
    [self.activityHeaderView.timeLabel setText:self.activity.formattedTime];
    [self.activityHeaderView.shortDescriptionLabel setText:[self.activity.shortDescription capitalizedString]];
    [self.activityHeaderView.feeLabel setText:self.activity.formattedAccessTypeAndPrice];
    CGSize headerIdealSize = [self.activityHeaderView idealSize];
    self.activityHeaderView.frame = CGRectMake(0.0, 0.0, headerIdealSize.width, headerIdealSize.height);
    [self.tableView setTableHeaderView:self.activityHeaderView];
    
    [[TCServerClient sharedTchillrServerClient] startInterestsRequestWithSuccess:^(NSArray *interestsArray) {
        self.interests = interestsArray;
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:KRowTags inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *error) {
        NSLog(@"%@", [error description]);
    }];
}

#pragma mark UITableViewDelegate / DataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return KNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = nil;
    switch (indexPath.row) {
        case KRowAddress:{
            TCAddressTableViewCell * addressTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCAddressTableViewCell class])];
            addressTableViewCell.placeLabel.text = self.activity.place;
            addressTableViewCell.addressLabel.text = self.activity.fullAddress;
            addressTableViewCell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_black"] highlightedImage:[UIImage imageNamed:@"arrow_black"]];
            [addressTableViewCell customizeAsWhiteCell];
            cell = addressTableViewCell;
        }           
            break;
        case KRowTags:{
            TCTagsTableViewCell * tagsTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCTagsTableViewCell class])];
            tagsTableViewCell.collectionView.tag = kTCActivityTagsCollectionViewTag;
            [tagsTableViewCell customizeAsWhiteCell];
            cell = tagsTableViewCell;
        }
            break;
        case KRowAttendance:{
            TCAttendanceTableViewCell * attendanceTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCAttendanceTableViewCell class])];
            cell = attendanceTableViewCell;
        }
            break;
        case KRowGallery:{
            TCGalleryTableViewCell * galleryTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCGalleryTableViewCell class])];
            galleryTableViewCell.collectionView.tag = kTCActivityGalleryCollectionViewTag;
            cell = galleryTableViewCell;
        }
            break;
        case KRowDescription:{
            TCDescriptionTableViewCell * descriptionTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCDescriptionTableViewCell class])];
            descriptionTableViewCell.descriptionLabel.text = self.activity.description;
            cell = descriptionTableViewCell;
        }
            break;
        default:
            break;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightForRowAtIndexPath = 0.0;
    switch (indexPath.row) {
        case KRowAddress:
        case KRowDescription:
        {
            UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            TCActivityDetailResizableCell * descriptionCell = (TCActivityDetailResizableCell *)cell;
            heightForRowAtIndexPath = [descriptionCell idealSizeForCell].height;
        }
            break;
        case KRowTags:
            heightForRowAtIndexPath = 90.0;
            break;
        case KRowAttendance:
            heightForRowAtIndexPath = 52.0;
            break;
        case KRowGallery:
            heightForRowAtIndexPath = ([self.activity hasMedias]) ? 137.0 : 0;
            break;
        default:
            break;
    }
    return heightForRowAtIndexPath;
}

#pragma mark Pop
- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UICollectionViewDelegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger numberOfItemsInSection = 0;
    if (collectionView.tag == kTCActivityTagsCollectionViewTag) {
        numberOfItemsInSection = [self.activity numberOfTags];
    }
    else if (collectionView.tag == kTCActivityGalleryCollectionViewTag) {
        numberOfItemsInSection = 1;
    }
    return numberOfItemsInSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cellForItemAtIndexPath = nil;
    if (collectionView.tag == kTCActivityTagsCollectionViewTag) {
        TCActivityTagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TCActivityTagsCollectionViewCell class]) forIndexPath:indexPath];
        TCTag * tag = [self.activity tagAtIndex:indexPath.row];
        cell.tagName.text = [tag.title uppercaseString];
        NSUInteger index = [self.interests indexOfObjectPassingTest:^BOOL(TCTag * tagObject, NSUInteger idx, BOOL *stop) {
            return [tag.identifier isEqualToNumber:tagObject.identifier];
        }];
        
        [cell setUserInterest:(index != NSNotFound)];
        [cell customizeWithStyle:indexPath.row];
        cellForItemAtIndexPath = cell;
    }
    else if (collectionView.tag == kTCActivityGalleryCollectionViewTag) {
        TCActivityGalleryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TCActivityGalleryCollectionViewCell class]) forIndexPath:indexPath];
        
        TCMedia * media = [self.activity mediaAtIndex:indexPath.row];
        if (media.path) {
            [media loadImageWithSuccess:^{
                cell.imageView.image = media.image;
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }       
        cellForItemAtIndexPath = cell;
    }
    return cellForItemAtIndexPath;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == kTCActivityTagsCollectionViewTag) {
        TCTag * tag = [self.activity tagAtIndex:indexPath.row];
        [[TCServerClient sharedTchillrServerClient] startUpdateInterestRequestWithIdentifier:tag.identifier success:^(NSArray *interestsArray) {
            self.interests = interestsArray;
            [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]];
        } failure:^(NSError *error) {
            NSLog(@"%@",[error description]);
        }];
    }
    else if (collectionView.tag == kTCActivityGalleryCollectionViewTag) {

    }
}

#define kShowRouteSegueIdentifier @"ShowRouteSegue"

#pragma mark Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:kShowRouteSegueIdentifier]) {
		TCRouteViewController *routeViewController = segue.destinationViewController;
		[routeViewController setActivity:self.activity];
	}
}

@end
