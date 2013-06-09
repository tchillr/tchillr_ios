//
//  InterestItemModel.m
//  BMInterestsPicker
//
//  Created by Meski Badr on 08/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import "InterestItemModel.h"

@interface InterestItemModel()

@property (nonatomic, retain, readwrite) NSString *title;
@property (nonatomic, retain, readwrite) UIColor *backgroundColor;
@property (nonatomic, retain, readwrite) UIColor *titleColor;

@end

@implementation InterestItemModel

@synthesize title = _title;
@synthesize backgroundColor = _backgroundColor;
@synthesize titleColor = _titleColor;

- (InterestItemModel *)initWithTitle:(NSString *)title backgroundColor:(UIColor *)bgColor andTitleColor:(UIColor *)titleColor {
    self = [super init];
    if(self) {
        self.title = title;
        self.backgroundColor = bgColor;
        self.titleColor = titleColor;
    }
    return self;
}


-(NSString *)description {
    return [NSString stringWithFormat:@"title : %@ , backgroundColor : %@, titleColor : %@, isOpen : %i",self.title, self.backgroundColor, self.titleColor, self.isOpen];
}

@end
