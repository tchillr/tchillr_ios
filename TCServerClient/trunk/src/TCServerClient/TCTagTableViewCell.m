//
//  TCTagTableViewCell.m
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCTagTableViewCell.h"

@implementation TCTagTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib{
    [self setup];
}

- (void)setup{
    [self.tagView.heartImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(heartTapped:)];
    [self.tagView.heartImageView addGestureRecognizer:tapGestureRecognizer];
}

- (void)heartTapped:(UITapGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateEnded && [self.delegate respondsToSelector:@selector(tagTableViewCellDidTapInterest:)]) {
        [self.delegate tagTableViewCellDidTapInterest:self];
    }
}

@end
