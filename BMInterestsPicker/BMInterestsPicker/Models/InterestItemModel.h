//
//  InterestItemModel.h
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterestItemModel : NSObject

@property (nonatomic, retain, readonly) NSString *title;
@property (nonatomic, retain, readonly) UIColor *backgroundColor;
@property (nonatomic, retain, readonly) UIColor *titleColor;
@property (nonatomic, assign, getter = isOpen) BOOL open;

- (InterestItemModel *)initWithTitle:(NSString *)title backgroundColor:(UIColor *)bgColor andTitleColor:(UIColor *)titleColor;

@end
