//
//  UIViewController+PCSideBarController.h
//  PCSideBarController
//
//  Created by Philippe on 18/03/2014.
//  Copyright (c) 2014 Philippe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCSideBarItem.h"

@class PCSideBarItem;

@interface UIViewController (PCSideBarController)
@property (nonatomic) PCSideBarItem* sideBarItem;
@end
