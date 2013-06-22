//
//  TCTagView.h
//  TCClient
//
//  Created by Jad on 08/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCTagView;

@protocol TCTagViewDelegate <NSObject>

- (void) tagView:(TCTagView *)tagView didTapHeart:(BOOL)selected;

@end

@interface TCTagView : UIView

@property (nonatomic, retain) IBOutlet UILabel * textLabel;
@property (nonatomic, retain) IBOutlet UIImageView * heartImageView;
@property (nonatomic, assign) BOOL userInterest;

@end
