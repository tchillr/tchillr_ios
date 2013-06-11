//
//  TCInterestModelDelegate.h
//  TCApp
//
//  Created by Jad on 11/06/13.
//  Copyright (c) 2013 Meski Badr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCInterestPickerItemCollectionViewCell;

@protocol TCInterestModelDelegate <NSObject>

- (NSArray *)userInterests;
- (void)interestItemCollectionViewCell:(TCInterestPickerItemCollectionViewCell *)cell triggeredTapForTagAtIndex:(NSInteger)index;

@end
