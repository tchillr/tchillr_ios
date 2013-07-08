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
#import "TCSelectedTagsView.h"

// Categories
#import "UIColor+Tchillr.h"

#import "TCTheme.h"
#import "TCTag.h"

@interface TCTastesCollectionViewCell ()

#pragma mark Setup
- (void)setup;

@end

@implementation TCTastesCollectionViewCell

@synthesize open = _open;
- (void)setOpen:(BOOL)open {
    if(open != _open) {
        _open = open;
    }
    [UIView animateWithDuration:0.250 animations:^{
        [self.tastesTableView setHidden:!_open];
        [self.selectedTagsView setHidden:_open];
        [self.titleLabel setHighlighted:_open];
    }];
}

@synthesize selectedTagsView = _selectedTagsView;
- (TCSelectedTagsView *)selectedTagsView {
    if(!_selectedTagsView) {
        _selectedTagsView = [[TCSelectedTagsView alloc] initWithFrame:CGRectMake(self.frame.size.width-(40+10), 10, 0, 0)];
        [_selectedTagsView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
        [self addSubview:_selectedTagsView];
    }
    return _selectedTagsView;
}

@synthesize selectedTagsIdentifiers = _selectedTagsIdentifiers;

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
}

#pragma mark Setup
- (void)setup {
	[self.titleLabel setTextColor:[UIColor tcBlack]];
	[self.titleLabel setHighlightedTextColor:[UIColor tcWhite]];
    self.tastesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.open = NO;
}

-(TCTheme*)themeAtIndex:(NSInteger)index{
    return [self.themesModelDelegate themeAtIndex:index];
}

#pragma mark - Tags TableView Delegate methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCTastesTagsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TCTastesTagsTableViewCell class]) forIndexPath:indexPath];

    TCTheme * theme = [self themeAtIndex:self.themeIndex];
    TCTag *currenTag = [theme tagAtIndex:indexPath.row];
    
    cell.tagLabel.text = currenTag.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.heartButton setUserInteractionEnabled:NO];
    [cell.heartButton setHighlighted:[self.selectedTagsIdentifiers containsObject:currenTag.identifier]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(tastesCollectionViewCell:didSelectTagAtIndex:)]) {
        [self.delegate tastesCollectionViewCell:self didSelectTagAtIndex:indexPath.row];
        [self.tastesTableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
#define kMaxNUmberOFTags 7
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TCTheme * theme = [self themeAtIndex:self.themeIndex];
    return [theme numberOfTags]>kMaxNUmberOFTags?kMaxNUmberOFTags:[theme numberOfTags];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
