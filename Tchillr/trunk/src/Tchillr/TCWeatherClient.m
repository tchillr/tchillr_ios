//
//  TCWeatherClient.m
//  Tchillr
//
//  Created by Jad on 03/07/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCWeatherClient.h"
//#import "XMLParser.h"

#define YAHOO_WEATHER_BASE [NSString stringWithFormat:@"http://weather.yahooapis.com/forecastrss?w=615702&u=c"]

#define weatherCode(dict) [[[[[dict objectForKey:@"rss"] objectForKey:@"channel"] objectForKey:@"item"] objectForKey:@"yweather:condition"] objectForKey:@"code"]


@implementation TCWeatherClient

#pragma mark Shared Instance
static TCWeatherClient *sharedInstance;
+ (void)initialize {
	static BOOL initialized = NO;
	if (!initialized) {
		initialized = YES;
		sharedInstance = [[TCWeatherClient alloc] init];
	}
}
+ (TCWeatherClient *)sharedInstance {
	return sharedInstance;
}
#pragma mark Weather
- (void)findWeatherCodeForParisWithCompletion:(void (^)(BOOL success, TCWeatherCode code, NSError *error))completion {
    NSString * requestURLString = YAHOO_WEATHER_BASE;
    NSURL *url = [NSURL URLWithString:requestURLString];
    NSData *weatherData = [NSData dataWithContentsOfURL:url];
    if (weatherData) {
        /*
        XMLParser * parser = [[XMLParser alloc] init];
        [parser parseData:weatherData success:^(id parsedData) {
            NSDictionary * weatherDict = (NSDictionary *)parsedData;
            NSNumber * weatherCode = weatherCode(weatherDict);
            TCWeatherCode code = [self weatherCodeFromValue:weatherCode];
            completion(YES, code, nil);
        } failure:^(NSError *error) {
            NSLog(@"Failed to retreive weather forecast");
            completion(NO, TCWeatherCodeNotAvailable, error);
        }];*/
    }
}
/*
0	tornado
1	tropical storm
2	hurricane
3	severe thunderstorms
4	thunderstorms
5	mixed rain and snow
6	mixed rain and sleet
7	mixed snow and sleet
8	freezing drizzle
9	drizzle
10	freezing rain
11	showers
12	showers
13	snow flurries
14	light snow showers
15	blowing snow
16	snow
17	hail
18	sleet
19	dust
20	foggy
21	haze
22	smoky
23	blustery
24	windy
25	cold
26	cloudy
27	mostly cloudy (night)
28	mostly cloudy (day)
29	partly cloudy (night)
30	partly cloudy (day)
31	clear (night)
32	sunny
33	fair (night)
34	fair (day)
35	mixed rain and hail
36	hot
37	isolated thunderstorms
38	scattered thunderstorms
39	scattered thunderstorms
40	scattered showers
41	heavy snow
42	scattered snow showers
43	heavy snow
44	partly cloudy
45	thundershowers
46	snow showers
47	isolated thundershowers
3200	not available
*/
#pragma mark Weather code from Yahoo Service Value
- (TCWeatherCode)weatherCodeFromValue:(NSNumber *)codeValue {
    TCWeatherCode weatherCode = TCWeatherCodeNotAvailable;
    switch ([codeValue intValue]) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
        case 16:
        case 17:
        case 18:
        case 19:
        case 20:
        case 21:
        case 22:
        case 23:
        case 24:
        case 25:
        case 35:
        case 37:
        case 38:
        case 39:
        case 40:
        case 41:
        case 42:
        case 43:
        case 45:
        case 46:
        case 47:
            weatherCode = TCWeatherCodeRaining;
            break;
        case 26:
        case 27:
        case 28:
        case 29:
        case 30:
        case 44:
            weatherCode = TCWeatherCodeCloudy;
            break;
        case 31:
        case 32:
        case 33:
        case 34:
        case 36:
            weatherCode = TCWeatherCodeSunny;
            break;
        default:
            weatherCode = TCWeatherCodeNotAvailable;
            break;
    }
    return weatherCode;
}

@end
