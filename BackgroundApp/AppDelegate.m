//
//  AppDelegate.m
//  BackgroundApp
//
//  Created by Vinod Vishwakarma on 05/02/15.
//  Copyright (c) 2015 Vinod Vishwakarma. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

AppDelegate *appDelegate = nil;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self appDelegateRefConfigure];
    
    self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] ] instantiateViewControllerWithIdentifier:@"SplashViewControllerIdentifier"];
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotification) {
        application.applicationIconBadgeNumber = 0;
    }
    
    
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    UIApplication *app = [UIApplication sharedApplication];
    
    //create new uiBackgroundTask
    __block UIBackgroundTaskIdentifier bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
   
    
    //------ method one -------
        //[self backgroundFetchMethod];
    //------- method two --------
    
    [self backgroundContinuousFetch:application];
    
    
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"########### Received Background Fetch ###########");
    //Download  the Content .
    [self backgroundFetchMethod];
    //Cleanup
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //and create new timer with async call:
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //run function methodRunAfterBackground
//        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:NO];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] run];
//    });
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  /*
    //and create new timer with async call:
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //run function methodRunAfterBackground
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:01 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
*/
    
    [self backgroundContinuousFetch:application];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

        application.applicationIconBadgeNumber = 0;
}

- (void)backgroundContinuousFetch:(UIApplication *)application {

//    __block UIBackgroundTaskIdentifier background_task;
//    
//    background_task = [application beginBackgroundTaskWithExpirationHandler:^ {
//        [application endBackgroundTask: background_task];
//        background_task = UIBackgroundTaskInvalid;
//    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        //run the app without startUpdatingLocation. backgroundTimeRemaining decremented from 600.00
       while(TRUE)
        {
            //backgroundTimeRemaining time does not go down.
            
            NSLog(@"Background time Remaining: %f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
            [NSThread sleepForTimeInterval:1]; //wait for 1 sec
            
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:01 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
        }
        
        //[application endBackgroundTask: background_task];
        //background_task = UIBackgroundTaskInvalid;
    });
}


- (void)backgroundFetchMethod {

    //and create new timer with async call:
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //run function methodRunAfterBackground
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(methodRunAfterBackground) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });

}

#pragma -
#pragma background and foreground  execution based on interval

- (void)methodRunAfterBackground {

//    NSDate *date = [NSDate date];
//    
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    localNotification.fireDate = [NSDate dateWithTimeInterval:60 sinceDate:date];
//    localNotification.alertBody = @"This is  the bg method running";
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];
//    localNotification.repeatInterval = 10;
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
 
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    localNotification.alertBody = @"local notification poc";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    NSLog(@"local notification");
}




#pragma -
#pragma AppDelegate Class Refrence

- (void)appDelegateRefConfigure {
    
    appDelegate = [[UIApplication sharedApplication] delegate];
}


@end
