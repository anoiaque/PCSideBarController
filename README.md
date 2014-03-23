# PCSideBarController

UIViewController which provide navigation via a side bar.

Side bar items are to select view controller and manage also actions buttons.

<!---

[![Version](http://cocoapod-badges.herokuapp.com/v/PCSideBarController/badge.png)](http://cocoadocs.org/docsets/PCSideBarController)
[![Platform](http://cocoapod-badges.herokuapp.com/p/PCSideBarController/badge.png)](http://cocoadocs.org/docsets/PCSideBarController)

-->
## Usage

-

Sample project using SideBarController under /Example: **PCSideBarController Sample.xcodeproj**

Here is a quick show :

![alt tag](https://raw.github.com/anoiaque/PCSideBarController/master/PCSideBarController-ScreenCast.gif)

###SideBarController

    PCSideBarController* sideBarController = [[PCSideBarController alloc]init];
    
    // Set a delegate if you want a callback on didSelectViewController:
    
    sideBarController.delegate = self;

    // Set SideBar background color
    
    sideBarController.sideBarBackgroundColor = [UIColor yellowColor];

    // Set a SideBar border (default NO)
    
    sideBarController.drawBorder = YES;

    // Set First item offset from top of sideBar view (default 0)
    
    sideBarController.leadingOffset = 100.0f;

    // Set Last item offset from bottom of sideBar view (default 0)
    
    sideBarController.tailingOffset = 20.0f;
    
    // Set overlay color of selected item
    
    sideBarController.sideBarItemHighlightedColor = [UIColor redColor];
    
    // Assign viewControllers for sideBar
    
    sideBarController.viewControllers = @[[[BookmarksViewController alloc] init],
                                           [[TodayViewController alloc] init]];
    
    // Add buttons items to sideBar (will be displayed after VC items)
    // Buttons items are not attached to any VC, they are to handle any action.
    
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

	// Assign actions items to side bar VC
	
    sideBarController.buttonsItems = @[pinActionItem];
    
    // Set Action Item active/inactive
    
    [sideBarController setActionItemAtIndex:0 active:YES];

### PCSideBarControllerDelegate

	Protocol : PCSideBarControllerDelegate
	Optional method : sideBarController:didSelectViewController:
	

	- (void)sideBarController:(PCSideBarController *)sideBarController didSelectViewController:(UIViewController *)viewController
	{
  	  NSLog(@"ViewController %@ Selected", viewController.class);
	}


### View controller assigned to SideBarController configuration

	@implementation BookmarksViewController

	- (id)init
	{
	  self = [super init];
	  if (self) {
	    self.sideBarItem.image = [UIImage imageNamed:@"bookmark"];
	    self.sideBarItem.title = @"Bookmarks";
	  }
	  return self;
	}
	...
	@end
## Installation

Copy sources files Classes/ios/*.{h,m}

-
PCSideBarController is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "PCSideBarController"


## Author

anoiaque, anoiaque@gmail.com

## License

PCSideBarController is available under the MIT license. See the LICENSE file for more info.

