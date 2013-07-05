//
//  TCAppDelegate.m
//  Tchillr
//
//  Created by Jad on 19/06/13.
//  Copyright (c) 2013 Tchillr. All rights reserved.
//

#import "TCAppDelegate.h"
#import "TCWeatherClient.h"
#import "TCServerClient.h"
#import "TCUser.h"

@implementation TCAppDelegate

@synthesize locationManager = _locationManager;
- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#warning calls the weather service / for testing
    [[TCWeatherClient sharedInstance] findWeatherCodeForParisWithCompletion:^(BOOL success, TCWeatherCode code, NSError *error) {
        
    }];
    
    [[TCServerClient sharedTchillrServerClient] startUserCreationRequestForUUIDString:[TCUser identifier] success:^(BOOL success) {

    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    // Location manager
    // Region monitoring
    if ([CLLocationManager regionMonitoringAvailable] && [CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"didEnterRegion");
    NSString * message = [NSString stringWithFormat:@"Il semblerait que tu ne sois pas très loin d'un plan sympa ! Veux-tu prévenir tes amis ?"];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Tchillr" message:message delegate:self cancelButtonTitle:@"Non !" otherButtonTitles:@"Oui !", nil];
    [alert show];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"didExitRegion");
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"Region monitoring failed with error: %@", [error localizedDescription]);
}

@end
