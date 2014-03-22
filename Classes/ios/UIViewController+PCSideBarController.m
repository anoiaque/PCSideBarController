//
//  UIViewController+PCSideBarController.m
//  PCSideBarController
//
//  Created by Philippe on 18/03/2014.
//  Copyright (c) 2014 Philippe. All rights reserved.
//

#import "UIViewController+PCSideBarController.h"
#import <objc/runtime.h>


@implementation UIViewController (PCSideBarController)

static char const * const PCSideBarItemKey = "PCSideBarItemKey";

- (void)setSideBarItem:(PCSideBarItem*)sideBarItem
{
  objc_setAssociatedObject(self, PCSideBarItemKey, sideBarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PCSideBarItem*)sideBarItem {
  
  PCSideBarItem* item = (PCSideBarItem*)objc_getAssociatedObject(self, PCSideBarItemKey);

  if (!item) {
    item = [[PCSideBarItem alloc] init];
    item.title = self.title;
    [self setSideBarItem:item];
  }
  
  return item;
}

@end
