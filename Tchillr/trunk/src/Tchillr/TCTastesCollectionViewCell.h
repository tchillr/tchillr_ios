//
//  TCTastesCollectionViewCell.h
//  Tchillr
//
//  Created by Zouhair on 25/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCThemesModelDelegate.h"

@class TCSelectedTagsView;
@class TCTastesCollectionViewCell;

@protocol TCTastesCollectionViewCellDelegate <NSObject>

- (void)tastesCollectionViewCell:(TCTastesCollectionViewCell *)cell didSelectTagAtIndex:(NSInteger)index;

@end

@interface TCTastesCollectionViewCell : UICollectionViewCell <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign, nonatomic) IBOutlet UITableView *tastesTableView;
@property (nonatomic, assign, getter = isOpen) BOOL open;
@property (retain, nonatomic) IBOutlet TCSelectedTagsView *selectedTagsView;
@property (nonatomic, assign) id<TCThemesModelDelegate> themesModelDelegate;
@property (nonatomic, assign) NSInteger themeIndex;
@property (nonatomic, assign) id<TCTastesCollectionViewCellDelegate> delegate;
@property (nonatomic, strong) NSArray *selectedTagsIdentifiers;

@end
