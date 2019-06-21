//
//  UIView+TYFrame.h
//  LabelTextPositionDemo
//
//  Created by Kystar on 2019/6/19.
//  Copyright © 2019 kystar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TYFrame)
- (CGFloat)ty_safeAreaLeft;
- (CGFloat)ty_safeAreaTop;
- (CGFloat)ty_safeAreaRight;
- (CGFloat)ty_safeAreaBottom;

@property (nonatomic, assign) CGFloat ty_left;
@property (nonatomic, assign) CGFloat ty_top;
@property (nonatomic, assign) CGFloat ty_right;
@property (nonatomic, assign) CGFloat ty_bottom;
@property (nonatomic, assign) CGFloat ty_width;
@property (nonatomic, assign) CGFloat ty_height;
@property (nonatomic, assign) CGFloat ty_centerX;
@property (nonatomic, assign) CGFloat ty_centerY;
@property (nonatomic, assign) CGPoint ty_origin;
@property (nonatomic, assign) CGSize ty_size;
@end

NS_ASSUME_NONNULL_END
