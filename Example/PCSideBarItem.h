//
//  PCSideBarItem.h
//  PCSideBarController
//
//  Created by Philippe on 18/03/2014.
//  Copyright (c) 2014 Philippe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCSideBarItem: NSObject

typedef void (^PCSideBarItemTouch)(NSIndexPath *);

@property (nonatomic, copy) PCSideBarItemTouch itemTouched;
@property (nonatomic, copy) PCSideBarItemTouch itemLongPressed;
@property (nonatomic) NSString* title;
@property (nonatomic) UIImage* image;
@property (nonatomic, getter = isActive) BOOL active;
@property (nonatomic, getter = isHidden) BOOL hidden;

@end
