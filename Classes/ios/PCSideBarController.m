//
//  PCSideBarController.m
//  PCSidebarController
//
//  Created by Philippe on 18/03/2014.
//  Copyright (c) 2014 Philippe. All rights reserved.
//

#import "PCSideBarController.h"
#import "UIViewController+PCSideBarController.h"
#import "PCSideBarItemCell.h"

@interface PCSideBarController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic) UIView *containerView;
@property(nonatomic) UITableView *itemsView;
@end

@implementation PCSideBarController

const CGFloat kpcSideBarWidth = 80.;
const CGFloat kpcSectionSpaceInterval = 160.;

#pragma mark - Init

- (instancetype)init
{
  if (self = [super init]) {

  }
  return self;
}

#pragma mark API methods

- (void)reloadContentView
{
  [self.containerView removeFromSuperview];
  [self.view addSubview:self.containerView];
}

- (void)reloadSideBar
{
  [self.itemsView reloadData];
}

- (void)setViewControllers:(NSArray*)viewControllers
{
  _viewControllers = viewControllers;
  
  for (UIViewController* controller in _viewControllers) {
    [self addChildViewController:controller];
  }
  
}

- (void)setActionItemAtIndex:(NSInteger)index active:(BOOL)isActive
{
  PCSideBarItem* item = [self.buttonsItems objectAtIndex:index];
  item.active = isActive;
  [self.itemsView reloadData];
}

#pragma mark - View/Layout

- (void)loadView
{
  [super loadView];
  [self.itemsView addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(iconLongPressedHandler:)]];

  if (self.drawBorder) [self drawSideBarBorder];

  [self.view addSubview:self.itemsView];
  [self.view addSubview:self.containerView];
}

- (void)drawSideBarBorder
{
  CALayer *rightBorder = [CALayer layer];
  rightBorder.borderColor = [UIColor blackColor].CGColor;
  rightBorder.borderWidth = 1.;
  rightBorder.frame = CGRectMake(-1, -1, CGRectGetWidth(self.itemsView.frame), CGRectGetHeight(self.itemsView.frame) + 2.);
  
  [self.view.layer addSublayer:rightBorder];
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  self.itemsView.contentInset = UIEdgeInsetsMake(self.leadingOffset, 0, self.tailingOffset, kpcSideBarWidth);
  self.itemsView.backgroundColor = self.sideBarBackgroundColor;
  self.activeViewController.view.frame = self.containerView.bounds;
}

#pragma mark - Properties

- (UITableView*)itemsView
{
  if (_itemsView == nil) {
    _itemsView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kpcSideBarWidth, self.view.bounds.size.height) style:UITableViewStylePlain];
    _itemsView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    _itemsView.backgroundColor = [UIColor clearColor];
    _itemsView.scrollEnabled = NO;
    _itemsView.dataSource = self;
    _itemsView.delegate = self;
    _itemsView.separatorStyle = UITableViewCellSeparatorStyleNone;
  }
  
  return _itemsView;
}

- (UIView*)containerView
{
  if (_containerView == nil) {
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(kpcSideBarWidth, 0, self.view.bounds.size.width - kpcSideBarWidth, self.view.bounds.size.height)];
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _containerView.clipsToBounds = YES;
  }
  
  return _containerView;
}

- (void)setActiveViewController:(UIViewController*)activeViewController
{
  if (_activeViewController != activeViewController) {
    [_activeViewController.view removeFromSuperview];
    _activeViewController = activeViewController;
    _activeViewController.view.alpha = 0.1f;
    
    [self.containerView addSubview:_activeViewController.view];
    
    [UIView animateWithDuration:1.0f animations:^{
      _activeViewController.view.alpha = 1.0f;
      
    } completion:^(BOOL finished) {
      [self.view setNeedsLayout];
      if ([self.delegate respondsToSelector:@selector(sideBarController:didSelectViewController:)]) {
        [self.delegate sideBarController:self didSelectViewController:_activeViewController];
      }
    }];
  }
}

#pragma mark - UITableView Data Source and Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return section == 0 ? [self.viewControllers count] : [self.buttonsItems count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return kpcSideBarWidth;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
  return section == 1 ? kpcSectionSpaceInterval : 0;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
  return [[UIView alloc] initWithFrame:CGRectZero] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([indexPath section] == 0) {
    self.activeViewController = self.viewControllers[indexPath.row];
  }
  else {
    PCSideBarItem* sideBarItem= (PCSideBarItem*)[self.buttonsItems objectAtIndex:[indexPath row]];
    sideBarItem.itemTouched(indexPath);
  }
  
  [self.itemsView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString* cellIdentifier = @"PCSideBarCell";
  PCSideBarItemCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) cell = [[PCSideBarItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  
  cell.highlightColor = self.sideBarItemHighlightedColor;

  if ([indexPath section] == 0)
  {
    UIViewController *viewController = self.viewControllers[indexPath.row];
    PCSideBarItem* sideBarItem = viewController.sideBarItem;
    if ([sideBarItem isHidden]) return cell;
    cell.textLabel.text = sideBarItem.title;
    cell.iconImage = sideBarItem.image;
    cell.isActive = (viewController == self.activeViewController);
  }
  else
  {
    PCSideBarItem* sideBarItem= (PCSideBarItem*)[self.buttonsItems objectAtIndex:[indexPath row]];
    if ([sideBarItem isHidden]) return cell;
    cell.textLabel.text = sideBarItem.title;
    cell.iconImage = sideBarItem.image;
    cell.isActive = sideBarItem.isActive;
  }
  

  return cell;
}

#pragma mark - Gestures handlers

- (void)iconLongPressedHandler:(UIGestureRecognizer*)gestureRecognizer
{
  if (gestureRecognizer.state == UIGestureRecognizerStateRecognized)
  {
    CGPoint touchPoint = [gestureRecognizer locationInView:self.itemsView];
    NSIndexPath* indexPath = [self.itemsView indexPathForRowAtPoint:touchPoint];
    if (indexPath == nil) return;
    
    if (indexPath.section == 0)
    {
      UIViewController* vc = self.viewControllers[indexPath.row];
      if (vc.sideBarItem.itemLongPressed) {
        vc.sideBarItem.itemLongPressed(indexPath);
      }
    }
    else
    {
      PCSideBarItem* actionItem = self.buttonsItems[indexPath.row];
      if (actionItem.itemLongPressed) {
        actionItem.itemLongPressed(indexPath);
      }
    }
  }
}

@end
