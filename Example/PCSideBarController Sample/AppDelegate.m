//
//  AppDelegate.m
//  PCSideBarController
//
//  Created by Philippe on 20/03/2014.
//  Copyright (c) 2014 Philippe. All rights reserved.
//

#import "AppDelegate.h"
#import "BookmarksViewController.h"
#import "TodayViewController.h"

@interface AppDelegate ()
@property(nonatomic, strong)PCSideBarController* sideBarController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  self.window.rootViewController = self.sideBarController;
  return YES;
}

#pragma mark - SideBarController init

- (PCSideBarController*)sideBarController
{
  if (_sideBarController == nil) {
    _sideBarController = [[PCSideBarController alloc]init];
    _sideBarController.delegate = self;

    // Set SideBar background color
    // _sideBarController.sideBarBackgroundColor = [UIColor yellowColor];

    // Set SideBar border
    // _sideBarController.drawBorder = YES;

    //first viewController item offset from top
    _sideBarController.leadingOffset = 100.;
    
    // overlay color of selected item
    _sideBarController.sideBarItemHighlightedColor = [UIColor redColor];
    
    // Assign viewControllers for sideBar
    _sideBarController.viewControllers = @[[[BookmarksViewController alloc] init],
                                           [[TodayViewController alloc] init]];
    
    // Add buttons items to sideBar (will be displayed after VC items)
    PCSideBarItem* pinActionItem = [[PCSideBarItem alloc]init];
    pinActionItem.image = [UIImage imageNamed:@"pin"];
    
    // Block action on touch
    pinActionItem.itemTouched = ^(NSIndexPath* indexPath){
      UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"SideBar Button Item" message:@"Pin Action" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
      [alertView show];
    };

    // Block action on long touch
    pinActionItem.itemLongPressed = ^(NSIndexPath* indexPath){
      UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"SideBar Button Item" message:@"Pin Action when long pressed" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
      [alertView show];
    };

    _sideBarController.buttonsItems = @[pinActionItem];
    
    // Set Action Item active
    //[_sideBarController setActionItemAtIndex:0 active:YES];
    
  }
  
  return _sideBarController;
}

- (void)sideBarController:(PCSideBarController *)sideBarController didSelectViewController:(UIViewController *)viewController
{
  NSLog(@"ViewController %@ Selected", viewController.class);
}

@end
