//
//  TCActivityDetailViewController.m
//  TCClient
//
//  Created by Jad on 04/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

// Categories

#import "TCActivityDetailViewController.h"
#import "TCConstants.h"
#import <MapKit/MapKit.h>
#import "TCTriangleView.h"
#import "UIColor+Tchillr.h"
#import "TCActivityDetailViewHeader.h"
#import "TCAddressTableViewCell.h"
#import "UITableViewCell+Tchillr.h"
#import "TCTagsTableViewCell.h"
#import "TCAttendanceTableViewCell.h"
#import "TCGalleryTableViewCell.h"

#define KNumberOfRows 4


@interface TCActivityDetailViewController ()


@property (weak, nonatomic) IBOutlet UILabel *activityDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityFullAddressLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *activityTagsView;
@property (weak, nonatomic) IBOutlet UILabel *activityNextOccurenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityContextualTags;

@property (weak, nonatomic) IBOutlet TCActivityDetailViewHeader *activityHeaderView;
@property (weak, nonatomic) IBOutlet UITableView * tableView;

@property (nonatomic, retain) IBOutlet UIButton * backButton;


@end

@implementation TCActivityDetailViewController

@synthesize activityHeaderView = _activityHeaderView;
@synthesize tableView = _tableView;


#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityHeaderView.nameLabel setText:[self.activity.name uppercaseString]];
    [self.activityHeaderView.dayLabel setText:self.activity.formattedDay];
    [self.activityHeaderView.timeLabel setText:self.activity.formattedTime];
    [self.activityHeaderView.shortDescriptionLabel setText:[self.activity.shortDescription capitalizedString]];
    [self.activityHeaderView.feeLabel setText:self.activity.formattedAccessTypeAndPrice];

    
    
    
    //[self.activityDescriptionLabel setText:self.activity.description];
    //[self.activityFullAddressLabel setText:self.activity.fullAddress];
    //[self.activityNextOccurenceLabel setText:self.activity.formattedOccurence];
    //[self.activityContextualTags setText:self.activity.formattedContextualTags];
}

#pragma mark UITableViewDelegate / DataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return KNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = nil;
    switch (indexPath.row) {
        case 0:{
            TCAddressTableViewCell * addressTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCAddressTableViewCell class])];
            addressTableViewCell.placeLabel.text = self.activity.place;
            addressTableViewCell.addressLabel.text = self.activity.fullAddress;
            addressTableViewCell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_black"] highlightedImage:[UIImage imageNamed:@"arrow_black"]];
            [addressTableViewCell customizeAsWhiteCell];
            cell = addressTableViewCell;
        }           
            break;
        case 1:{
            TCTagsTableViewCell * tagsTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCTagsTableViewCell class])];
            [tagsTableViewCell customizeAsWhiteCell];
            cell = tagsTableViewCell;
        }
            break;
        case 2:{
            TCAttendanceTableViewCell * attendanceTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCAttendanceTableViewCell class])];
            cell = attendanceTableViewCell;
        }
            break;
        case 3:{
            TCGalleryTableViewCell * galleryTableViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCGalleryTableViewCell class])];
            cell = galleryTableViewCell;
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
        case 0:
            heightForRowAtIndexPath = 60.0;
            break;
        case 1:
            heightForRowAtIndexPath = 90.0;
            break;
        case 2:
            heightForRowAtIndexPath = 52.0;
            break;
        case 3:
            heightForRowAtIndexPath = 135.0;
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

@end
