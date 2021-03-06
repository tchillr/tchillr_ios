//
//  TCConstants.h
//  Tchillr
//
//  Created by Jad on 19/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#ifndef Tchillr_TCConstants_h
#define Tchillr_TCConstants_h

/* iPhone 4/5 Specs */
#define kIphone4DefaultImage [UIImage imageNamed:@"Default"]
#define kIphone5DefaultImage [UIImage imageNamed:@"Default-568h"]
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define kDefaultImage (IS_IPHONE_5) ? kIphone5DefaultImage : kIphone4DefaultImage


/************************/
/***** Progress Hud *****/
/************************/
#define SHOW_PROGRESS_HUD @"SHOW_PROGRESS_HUD"
#define HIDE_PROGRESS_HUD @"HIDE_PROGRESS_HUD"
#define kHudTargetView @"kHudTargetView"
#define kHudCustomView @"kHudCustomView"

#endif
