//
//  PCSideBarController.h
//  PCSidebarController
//
//  Created by Philippe on 18/03/2014.
//  Copyright (c) 2014 Philippe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCSideBarItem.h"
#import "UIViewController+PCSideBarController.h"

@protocol PCSideBarControllerDelegate;

@interface PCSideBarController : UIViewController

@property (nonatomic, copy) NSArray* viewControllers;
@property (nonatomic, weak) UIViewController* activeViewController;
@property (nonatomic, weak) id<PCSideBarControllerDelegate> delegate;
@property (nonatomic, copy) NSArray* buttonsItems;

@property (nonatomic, copy) UIColor* sideBarBackgroundColor;
@property (nonatomic, copy) UIColor* sideBarItemHighlightedColor;
@property (nonatomic) CGFloat leadingOffset;
@property (nonatomic) CGFloat tailingOffset;
@property (nonatomic) BOOL drawBorder;

- (void)reloadSideBar;
- (void)reloadContentView;
- (void)setActionItemAtIndex:(NSInteger)index active:(BOOL)isActive;

@end

@protocol PCSideBarControllerDelegate <NSObject>
@optional
- (void)sideBarController:(PCSideBarController*)sideBarController didSelectViewController:(UIViewController*)viewController;
@end
