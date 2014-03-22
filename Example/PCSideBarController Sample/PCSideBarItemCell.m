//
//  PCSideBarItemCellTableViewCell.m
//  PCSideBarController
//
//  Created by Philippe on 18/03/2014.
//  Copyright (c) 2014 Philippe. All rights reserved.
//

#import "PCSideBarItemCell.h"

@interface PCSideBarItemCell ()
@property (nonatomic) UIImage* highlightedIconImage;
@end

@implementation PCSideBarItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [UIFont boldSystemFontOfSize:11];
  }
  
  return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
  [super layoutSubviews];
  CGFloat x = (self.bounds.size.width - self.iconImage.size.width) / 2.;
  self.imageView.frame = CGRectMake(x, 0, self.iconImage.size.width, self.iconImage.size.height);
  self.textLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 4, self.bounds.size.width, 20);
}

#pragma mark - Properties

- (UIColor*)highlightColor
{
  if (_highlightColor == nil) {
    _highlightColor = [UIColor colorWithRed:0.1 green:0.2 blue:0.7 alpha:1.0];
  }
  
  return _highlightColor;
}

- (UIImage*)highlightedIconImage
{
  if (_highlightedIconImage == nil) {
    _highlightedIconImage = [self overlayImage:self.iconImage WithColor:self.highlightColor];
  }
  return _highlightedIconImage;
}

- (void)setIsActive:(BOOL)isActive
{
  _isActive = isActive;
  self.imageView.image = self.iconImage;
  self.imageView.highlightedImage = self.highlightedIconImage;
  self.imageView.highlighted = self.isActive;
}

#pragma mark - Highlighted Image Builder

- (UIImage*)overlayImage:(UIImage*)image WithColor:(UIColor*)color
{
  CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, 100, 100);
  
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  [color setFill];
  CGContextFillRect(context, rect);
  
  CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
  [image drawInRect: rect blendMode:kCGBlendModeDestinationIn alpha:1.];
  
  UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  
  return img;
}

@end
