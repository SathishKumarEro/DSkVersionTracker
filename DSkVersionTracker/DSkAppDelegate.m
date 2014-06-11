//
//  DSkAppDelegate.m
//  DSkVersionTracker
//
//  Created by Sathish Kumar on 11/06/14.
//  Copyright (c) 2014 USAWeb, Inc. All rights reserved.
//

#import "DSkAppDelegate.h"

#import "DSKVersionChecker.h"


@implementation DSkAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self CheckForNewVersion];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}



-(void) CheckForNewVersion
{
    
    NSString *ResetDate;
    
    NSUserDefaults *AutomaticSyncUserDefaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"AutomaticSyncUserDefaults=%@",[AutomaticSyncUserDefaults objectForKey:@"Date"]);
    
    
    // Get Today
    NSDate *TodayDate = [[NSDate alloc] init];
    
    NSDateFormatter *DateFormat= [[NSDateFormatter alloc] init];
    [DateFormat setDateFormat:@"dd-MM-yyyy"];
    
    NSString *TodayString = [DateFormat stringFromDate:TodayDate];
    NSLog(@"Today String: %@", TodayString);
    
    
    
    // Get DayAfterTomorrow
    NSDate *DayAfterTomorrowString = [[NSDate alloc] init];
    
    TodayDate=[DateFormat dateFromString:TodayString];
    DayAfterTomorrowString=[DateFormat dateFromString:[AutomaticSyncUserDefaults objectForKey:@"Date"]];
    //DayAfterTomorrowString=[DateFormat dateFromString:@"11-06-2013"];
    
    
    NSComparisonResult result = [TodayDate compare:DayAfterTomorrowString];
    
    switch (result)
    {
            
        case
        NSOrderedAscending: NSLog(@"%@ is greater than %@", DayAfterTomorrowString, TodayDate);
            break;
            
        case
        NSOrderedDescending: NSLog(@"%@ is less %@", DayAfterTomorrowString, TodayDate);
            ResetDate=@"Reset";
            break;
            
        case
        NSOrderedSame: NSLog(@"%@ is equal to %@", DayAfterTomorrowString, TodayDate);
            break;
            
        default:
            NSLog(@"erorr dates %@, %@", DayAfterTomorrowString, TodayDate);
            break;
            
    }
    
    
    
    
    
    if (([[AutomaticSyncUserDefaults objectForKey:@"Date"] length]==0) || ([[AutomaticSyncUserDefaults objectForKey:@"Date"] isEqualToString:TodayString])||([ResetDate isEqualToString:@"Reset"]))
    {
        
        // Get DayAfterTomorrow Date
        NSDate *DayAfterTomorrow = [NSDate dateWithTimeInterval:((24*60*60)*2) sinceDate:[NSDate date]];
        NSLog(@"Today=%@",[NSDate date]);
        NSLog(@"DayAfterTomorrow=%@",DayAfterTomorrow);
        
        NSDateFormatter *DateFormat= [[NSDateFormatter alloc] init];
        [DateFormat setDateFormat:@"dd-MM-yyyy"];
        NSString *DayAfterTomorrowString = [DateFormat stringFromDate:DayAfterTomorrow];
        
        NSLog(@"Normal Full date: %@", [NSDate date]);
        NSLog(@"Day After Tomorrow String: %@", DayAfterTomorrowString);
        
        
        NSUserDefaults *AutomaticSyncUserDefaults = [NSUserDefaults standardUserDefaults];
        [AutomaticSyncUserDefaults setObject:DayAfterTomorrowString forKey:@"Date"];
        
        [AutomaticSyncUserDefaults synchronize];
        
        
        
        [DSKVersionChecker checkForUpdate];
        
        
    }
    
    
    
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


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
