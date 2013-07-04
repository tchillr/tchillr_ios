//
//  TCWeatherClient.h
//  Tchillr
//
//  Created by Jad on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum{
    TCWeatherCodeNotAvailable,
    TCWeatherCodeSunny,
    TCWeatherCodeRaining,
    TCWeatherCodeCloudy
}TCWeatherCode;

@interface TCWeatherClient : NSObject

#pragma mark Shared Instance
+ (TCWeatherClient *)sharedInstance;

#pragma mark Weather for Paris
- (void)findWeatherCodeForParisWithCompletion:(void (^)(BOOL success, TCWeatherCode code, NSError *error))completion;

@end
