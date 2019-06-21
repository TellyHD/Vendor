//
//  PTAnimateScrollTextPresenter.h
//  LabelTextPositionDemo
//
//  Created by Kystar on 2019/6/20.
//  Copyright © 2019 kystar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTTextScrollTypeDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTAnimateScrollTextPresenter : NSObject

//动画的源视图,每次重新赋值时，都会重新创建用于动画的子视图，之前的子视图移除
@property (nonatomic, strong) UILabel<NSCopying> *originLabel;
//源视图未做动画之前的frame
@property (nonatomic, assign) CGRect originLabelFrame;
//动画中的视图是否首尾相连，默认值：YES
@property (nonatomic, assign) BOOL annular;
//文本滚动类型，默认值：PTTextScrollTypeLeftToRight
@property (nonatomic, assign) PTTextScrollType scrollType;
//视图frame变化步长，默认值为2
@property (nonatomic, assign) CGFloat scrollStep;
@property (nonatomic, assign) CGFloat scale;

+ (instancetype)pt_sharedInstance;

- (void)pt_startAnimateWithScrollType:(PTTextScrollType)scrollType;

- (void)pt_startAnimateWithAnnular:(BOOL)annular;

- (void)pt_startAnimateWithScrollStep:(CGFloat)scrollStep;

- (void)pt_startAnimateWithOriginLabel:(UILabel<NSCopying> *)originLabel;

- (void)pt_startAnimateWithScrollType:(PTTextScrollType)scrollType annular:(BOOL)annular scrollStep:(CGFloat)scrollStep originLabel:(UILabel<NSCopying> * _Nullable )originLabel;



- (void)ty_stopAnimate;

@end

NS_ASSUME_NONNULL_END
