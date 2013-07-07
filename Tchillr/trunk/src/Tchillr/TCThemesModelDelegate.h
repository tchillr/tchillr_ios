//
//  TCThemesModelDelegate.h
//  Tchillr
//
//  Created by Jad on 07/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TCTheme;

@protocol TCThemesModelDelegate <NSObject>

-(TCTheme *)themeAtIndex:(NSInteger)index;

@end
