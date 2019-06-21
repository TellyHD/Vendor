//
//  UIView+TYFrame.m
//  LabelTextPositionDemo
//
//  Created by Kystar on 2019/6/19.
//  Copyright © 2019 kystar. All rights reserved.
//

#import "UIView+TYFrame.h"

@implementation UIView (TYFrame)

- (CGFloat)ty_safeAreaLeft {
    return self.safeAreaInsets.left;
}

- (CGFloat)ty_safeAreaTop {
    return self.safeAreaInsets.top;
}

- (CGFloat)ty_safeAreaRight{
    return self.safeAreaInsets.right;
}

- (CGFloat)ty_safeAreaBottom {
    return self.safeAreaInsets.bottom;
}



#pragma mark - Getter
- (CGFloat)ty_left {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)ty_top {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)ty_right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)ty_bottom {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)ty_width {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)ty_height {
    return CGRectGetHeight(self.frame);
}

- (CGFloat)ty_centerX {
    return self.ty_left + self.ty_width / 2;
}

- (CGFloat)ty_centerY {
    return self.ty_top + self.ty_height / 2;
}

- (CGPoint)ty_origin {
    return self.frame.origin;
}

- (CGSize)ty_size {
    return self.frame.size;
}


#pragma mark - Setter
- (void)setTy_left:(CGFloat)ty_left {
    CGRect frame = self.frame;
    frame.origin.x = ty_left;
    self.frame = frame;
}

- (void)setTy_top:(CGFloat)ty_top {
    CGRect frame = self.frame;
    frame.origin.y = ty_top;
    self.frame = frame;
}

- (void)setTy_right:(CGFloat)ty_right {
    CGRect frame = self.frame;
    frame.origin.x = ty_right - self.ty_width;
    self.frame = frame;
}

- (void)setTy_bottom:(CGFloat)ty_bottom {
    CGRect frame = self.frame;
    frame.origin.y = ty_bottom - self.ty_height;
    self.frame = frame;
}

- (void)setTy_width:(CGFloat)ty_width {
    CGRect frame = self.frame;
    frame.size.width = ty_width;
    self.frame = frame;
}

- (void)setTy_height:(CGFloat)ty_height {
    CGRect frame = self.frame;
    frame.size.height = ty_height;
    self.frame = frame;
}

- (void)setTy_centerX:(CGFloat)ty_centerX {
    CGRect frame = self.frame;
    frame.origin.x = ty_centerX - self.ty_width / 2;
    self.frame = frame;
}

- (void)setTy_centerY:(CGFloat)ty_centerY {
    CGRect frame = self.frame;
    frame.origin.y = ty_centerY - self.ty_height / 2;
    self.frame = frame;
}

- (void)setTy_origin:(CGPoint)ty_origin {
    CGRect frame = self.frame;
    frame.origin = ty_origin;
    self.frame = frame;
}

- (void)setTy_size:(CGSize)ty_size {
    CGRect frame = self.frame;
    frame.size = ty_size;
    self.frame = frame;
}

@end
