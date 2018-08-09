//
//  AppDelegate.m
//  Rawabi
//
//  Created by Ghadeer Abualrub on 7/12/18.
//  Copyright © 2018 asal. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()
{
    SignInViewController* nextVC1 ;//= [st1 instantiateViewControllerWithIdentifier:@"SignInViewController"];
    UIViewController* nextVC2 ;//= [st1 instantiateViewControllerWithIdentifier:@"nextVC"];
    ViewController* welcomeController ;//= [st1 instantiateViewControllerWithIdentifier:@"FirstViewController"];
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:161.0/255.0 green:210.0/255.0 blue:103.0/255.0 alpha:1.0]];
    
    [[UITabBar appearance]setTintColor:[UIColor colorWithRed:161.0/255.0 green:210.0/255.0 blue:103.0/255.0 alpha:1.0]];
    
    UIStoryboard* st1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    nextVC1 = [st1 instantiateViewControllerWithIdentifier:@"SignInViewController"];
    nextVC2 = [st1 instantiateViewControllerWithIdentifier:@"controller"];
    welcomeController = [st1 instantiateViewControllerWithIdentifier:@"FirstViewController"];
    
    if(!user){
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.window.rootViewController.navigationController pushViewController:welcomeController animated:YES];});
    }
    
    if([user objectForKey:@"currentUser"] && [user objectForKey:@"currentPassword"] ){
        NSLog(@"eeeuser%@%@", [user objectForKey:@"currentUser"], [user objectForKey:@"currentPassword"]);
        NSString * email = [[NSString alloc]initWithString:[user objectForKey:@"currentUser"]];
        NSString * password = [[NSString alloc]initWithString:[user objectForKey:@"currentPassword"]];
        // login stratigy

        [nextVC1 createPostBodyWithEmail:email AndPassword:password];
        [nextVC1 postHttpRequest];
        [nextVC1 presentViewController:nextVC2 animated:YES completion:nil];
        
    }
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:161.0/255.0 green:210.0/255.0 blue:103.0/255.0 alpha:1.0];
    pageControl.backgroundColor = [UIColor whiteColor];


  
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
