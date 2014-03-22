//
//  BookmarksViewController.m
//  PCSideBarController
//
//  Created by Philippe on 20/03/2014.
//  Copyright (c) 2014 Philippe. All rights reserved.
//

#import "BookmarksViewController.h"
#import "UIViewController+PCSideBarController.h"

@interface BookmarksViewController ()

@end

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

- (void)loadView
{
  [super loadView];
  UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
  titleLabel.text = @"Bookmarks Controller";
  titleLabel.center = self.view.center;
  [self.view addSubview:titleLabel];
}


@end
