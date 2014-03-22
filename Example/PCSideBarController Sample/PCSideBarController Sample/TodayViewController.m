//
//  TodayViewController.m
//  PCSideBarController
//
//  Created by Philippe on 20/03/2014.
//  Copyright (c) 2014 Philippe. All rights reserved.
//

#import "TodayViewController.h"
#import "UIViewController+PCSideBarController.h"

@interface TodayViewController ()
@property(nonatomic) UILabel* titleLabel;
@end

@implementation TodayViewController

- (id)init
{
  self = [super init];
  if (self) {
    self.sideBarItem.image = [UIImage imageNamed:@"calendar"];
    self.sideBarItem.title = @"Today";
    
    __block TodayViewController* weakSelf = self;
    self.sideBarItem.itemLongPressed = ^(NSIndexPath* _){
      weakSelf.titleLabel.textColor = [UIColor redColor];
    };
  }
  return self;
}

- (void)loadView
{
  [super loadView];
  _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 60)];
  _titleLabel.text = @"Today Controller";
  _titleLabel.center = self.view.center;
  [self.view addSubview:_titleLabel];
}


@end
