//
//  DSKVersionChecker.h
//  DSkVersionTracker
//
//  Created by Sathish Kumar on 11/06/14.
//  Copyright (c) 2014 USAWeb, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSKVersionChecker : NSObject <UIAlertViewDelegate>

/** Checks for update and presents a UIAlertView if there is an update available.
 
 */
+ (void) checkForUpdate;

/** Checks for update and calls the handler block to present your own UI or do whatever you want.
 
 @param handler Block that is only called if an update is available.
 */
+ (void) checkForUpdateWithHandler:(void (^)(NSString *appStoreVersion, NSString *localVersion, NSString *releaseNotes, NSString *updateURL))handler;

@end
