//
//  TCTastesCollectionViewCell.m
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTastesCollectionViewCell.h"

// Views
#import "TCTastesTagsTableViewCell.h"

// Categories
#import "UIColor+Tchillr.h"

@interface TCTastesCollectionViewCell ()

#pragma mark Setup
- (void)setup;

@end

@implementation TCTastesCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setup];
	}
	return self;
}
- (void)awakeFromNib {
	[super awakeFromNib];
	[self setup];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.titleLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
	self.titleLabel.frame = CGRectMake(self.bounds.size.width - self.titleLabel.frame.size.width - 10.0,
									   self.bounds.size.height - self.titleLabel.frame.size.height - 50.0,
									   self.titleLabel.frame.size.width,
									   self.titleLabel.frame.size.height);
    [self.tastesTableView setHidden:!self.selected];
}

-(void)setSelected:(BOOL)selected {
    NSLog(@"self.selected : %d ,selected : %d",self.selected,selected);
    if(self.selected != selected) {
        [super setSelected:selected];
    }
}
#pragma mark Setup
- (void)setup {
	[self.titleLabel setTextColor:[UIColor tcBlack]];
	[self.titleLabel setHighlightedTextColor:[UIColor tcWhite]];
    self.tastesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.open = NO;
}

#pragma mark - TableView Delegate methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCTastesTagsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCTastesTagsTableViewCell class]) forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.tagLabel.text = @"test";

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
