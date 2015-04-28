//
//  AppDelegate.m
//  SightCallClient
//
//  Created by Ihawk on 4/23/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "AppDelegate.h"
#import "Log.h"
#import <sys/utsname.h>

void uncaughtExceptionHandler(NSException *exception) {
	[Log logException:exception];
}

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[Log log:@"SightCallClient Started" params:@"at  Device \"%@\" %@ %@ %@ on %@", [[UIDevice currentDevice] name], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion], [NSDate date]];
	
	// Override point for customization after application launch.
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
	
	struct sigaction mySigAction;
	mySigAction.sa_sigaction = mysighandler;
	mySigAction.sa_flags = SA_SIGINFO;
	sigemptyset(&mySigAction.sa_mask);
	sigaction(SIGQUIT, &mySigAction, NULL);
	sigaction(SIGILL, &mySigAction, NULL);
	sigaction(SIGTRAP, &mySigAction, NULL);
	sigaction(SIGABRT, &mySigAction, NULL);
	sigaction(SIGEMT, &mySigAction, NULL);
	sigaction(SIGFPE, &mySigAction, NULL);
	sigaction(SIGBUS, &mySigAction, NULL);
	sigaction(SIGSEGV, &mySigAction, NULL);
	sigaction(SIGSYS, &mySigAction, NULL);
	sigaction(SIGPIPE, &mySigAction, NULL);
	sigaction(SIGALRM, &mySigAction, NULL);
	sigaction(SIGXCPU, &mySigAction, NULL);
	sigaction(SIGXFSZ, &mySigAction, NULL);
	return YES;
}

void mysighandler(int sig, siginfo_t *info, void *context) {
	[Log logSignal:sig info:info context:context stackFrames:[NSThread callStackSymbols] returnAddresses:[NSThread callStackReturnAddresses]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
