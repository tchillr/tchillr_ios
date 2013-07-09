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
#import "MBProgressHUD.h"
#import "TCConstants.h"

@interface TCAppDelegate() <MBProgressHUDDelegate>

@property (nonatomic, retain) MBProgressHUD *progressHud;

@end

@implementation TCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[TCServerClient sharedTchillrServerClient] startUserCreationRequestForUUIDString:[TCUser identifier] success:^(BOOL success) {
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showProgressHud:) name:SHOW_PROGRESS_HUD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideProgressHud:) name:HIDE_PROGRESS_HUD object:nil];

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

#pragma mark MBProgressHud Management
- (void)showProgressHud:(NSNotification *)notification {
    UIView *view = nil;
    UIView *customView = nil;
    if ([notification.object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)notification.object;
        view = [[dic allKeys] containsObject:kHudTargetView]?[dic objectForKey:kHudTargetView]:nil;
        customView = [[dic allKeys] containsObject:kHudCustomView]?[dic objectForKey:kHudCustomView]:nil;
    }
    else {
        view = [notification object];
    }
	if (!view) {
		view = self.window;
	}
	if (self.progressHud) {
		[self.progressHud hide:YES];
		[self setProgressHud:nil];
	}
	if (!self.progressHud) {
		MBProgressHUD *tmpProgressHud = [[MBProgressHUD alloc] initWithView:view];
		self.progressHud = tmpProgressHud;
		self.progressHud.delegate = self;
		self.progressHud.dimBackground = YES;
	}
    if (customView) {
        self.progressHud.mode = MBProgressHUDModeCustomViewComplete;
        [self.progressHud setCustomView:customView];
    }
	[view addSubview:self.progressHud];
	[self.progressHud show:YES];
}

- (void)hideProgressHud:(NSNotification *)notification {
	[self.progressHud hide:YES];
}

#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
	[hud removeFromSuperview];
}


@end
