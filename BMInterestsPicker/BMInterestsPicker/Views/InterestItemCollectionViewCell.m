//
//  InterestItemCollectionViewCell.m
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "InterestItemCollectionViewCell.h"

// Model
#import "InterestItemModel.h"

// Categories
#import "NSArray+BMAddings.h"
#import "UIColor+BMAddings.h"

// Views
#import "TagItemCollectionViewCell.h"

@interface InterestItemCollectionViewCell ()

@property (nonatomic, retain, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain, readwrite) IBOutlet UIView *frontView;

@property (nonatomic, assign, readwrite, getter = isOpen) BOOL open;

@property (nonatomic, retain, readwrite) NSArray *tags;
@property (nonatomic, retain, readwrite) IBOutlet UICollectionView *collectionView;

@end

@implementation InterestItemCollectionViewCell

#pragma mark getters/setters
@synthesize title = _title;
- (void)setTitle:(NSString *)title {
    if(![_title isEqualToString:title]) {
        _title = [title uppercaseString];
        [self.titleLabel setText:_title];
        [self setNeedsLayout];
    }
}

@synthesize titleColor = _titleColor;
- (void)setTitleColor:(UIColor *)titleColor {
    if(![_titleColor isEqual:titleColor]) {
        _titleColor = titleColor;
        [self.titleLabel setTextColor:_titleColor];
    }
}

@synthesize frontColor = _frontColor;
- (void)setFrontColor:(UIColor *)frontColor {
    if(![_frontColor isEqual:frontColor]) {
        _frontColor = frontColor;
        [self.frontView setBackgroundColor:frontColor];
    }
}

@synthesize tags = _tags;
-(NSArray *)tags {
    if(!_tags) {
        _tags = [[NSArray alloc] initWithTitlesBackgroundColorsAndTitleColors:
                      @"Nature",[UIColor colorWithCommaSeparatedRGBString:@"219	126	80	0.8"],[UIColor colorWithCommaSeparatedRGBString:@"60	58	55	"],
                      @"Sport",[UIColor colorWithCommaSeparatedRGBString:@"129	157	122	0.8"],[UIColor colorWithCommaSeparatedRGBString:@"238	236	216	"],
                      @"Expos",[UIColor colorWithCommaSeparatedRGBString:@"245	232	145	0.8"],[UIColor colorWithCommaSeparatedRGBString:@"57	57	56	"],
                      @"Concerts",[UIColor colorWithCommaSeparatedRGBString:@"101	119	147	0.8"],[UIColor colorWithCommaSeparatedRGBString:@"238	236	216	"],
                 @"Nature",[UIColor colorWithCommaSeparatedRGBString:@"219	126	80	0.8"],[UIColor colorWithCommaSeparatedRGBString:@"60	58	55	"],
                 @"Sport",[UIColor colorWithCommaSeparatedRGBString:@"129	157	122	0.8"],[UIColor colorWithCommaSeparatedRGBString:@"238	236	216	"],
                 @"Expos",[UIColor colorWithCommaSeparatedRGBString:@"245	232	145	0.8"],[UIColor colorWithCommaSeparatedRGBString:@"57	57	56	"],
                 @"Concerts",[UIColor colorWithCommaSeparatedRGBString:@"101	119	147	0.8"],[UIColor colorWithCommaSeparatedRGBString:@"238	236	216	"],
                      nil];
    }
    return _tags;
}

#pragma mark - LifeCycles Methods
- (void)layoutSubviews {
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(self.frame.size.width-20,self.frame.size.height)];
    
    CGFloat originX = self.isOpen ? 10 : self.frame.size.width-titleSize.width-10;
    [self.titleLabel setFrame:CGRectMake(originX, self.titleLabel.frame.origin.y, titleSize.width, titleSize.height)];
}

- (void)awakeFromNib {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frontViewHasBeenTapped:)];
    [self.frontView addGestureRecognizer:tapGesture];
}

#pragma mark - UIGestureRecognizer Methods
- (void)frontViewHasBeenTapped:(UITapGestureRecognizer *)tapGesture {
    if([tapGesture state] == UIGestureRecognizerStateEnded) {
        if([self.delegate respondsToSelector:@selector(interestItemCollectionViewCell:frontViewHasBeenTapped:)]) {
            [self.delegate interestItemCollectionViewCell:self frontViewHasBeenTapped:self.frontView];
        }
    }
}

#pragma mark - Front View Interaction Methods
- (void)openCellAnimated:(void (^)(void))complete {
    if(![self isOpen]) {
        [UIView animateWithDuration:0.350 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.frontView setFrame:CGRectMake(0, -134, self.frontView.frame.size.width, self.frontView.frame.size.height)];
            [UIView animateWithDuration:0.350 delay:0.150 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.titleLabel setFrame:CGRectMake(10, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
            } completion:^(BOOL finished) {
            }];
        } completion:^(BOOL finished) {
            self.open = YES;
            complete();
        }];
    }
}

- (void)closeCellAnimated:(void (^)(void))complete {
    if([self isOpen]) {
        [UIView animateWithDuration:0.350 animations:^{
            [self.titleLabel setFrame:CGRectMake(self.frame.size.width-self.titleLabel.frame.size.width-10, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
            [UIView animateWithDuration:0.350 delay:0.150 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.frontView setFrame:CGRectMake(0, 0, self.frontView.frame.size.width, self.frontView.frame.size.height)];
            } completion:^(BOOL finished) {
            }];
        } completion:^(BOOL finished) {
            self.open = NO;
            complete();
        }];
    }
}
- (void)openCell {
    if(![self isOpen]) {
        [self.frontView setFrame:CGRectMake(0, -134, self.frontView.frame.size.width, self.frontView.frame.size.height)];
        [self.titleLabel setFrame:CGRectMake(10, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
        self.open = YES;
    }
}
- (void)closeCell {
    if([self isOpen]) {
        [self.titleLabel setFrame:CGRectMake(self.frame.size.width-self.titleLabel.frame.size.width-10, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
            [self.frontView setFrame:CGRectMake(0, 0, self.frontView.frame.size.width, self.frontView.frame.size.height)];
        self.open = NO;
    }
}

#pragma mark - UICollectionView Detail Delegate methods

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfTags];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TagItemCollectionViewCell class]) forIndexPath:indexPath];
    if(cell) {
        
    }
    
    InterestItemModel *interest = [self tagAtIndex:indexPath.row];
    
    cell.backgroundColor = [interest backgroundColor];
    cell.backgroundView.alpha = 0.8;
    cell.titleColor = [interest titleColor];
    cell.title = [interest title];
    
    return cell;
}

#pragma mark - Tags Collection Methods
- (InterestItemModel *)tagAtIndex:(NSUInteger)index {
    return [self.tags objectAtIndex:index];
}
- (NSUInteger)numberOfTags {
    return [self.tags count];
}

#pragma mark - TagCollectionViewCell Delegate Methods
- (void)tagItemCollectionViewCellHasBeenTapped:(TagItemCollectionViewCell *)cell {
    
}

@end
