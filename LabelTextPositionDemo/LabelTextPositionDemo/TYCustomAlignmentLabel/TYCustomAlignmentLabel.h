//
//  TYCustomAlignmentLabel.h
//  LabelTextPositionDemo
//
//  Created by Kystar on 2019/6/18.
//  Copyright © 2019 kystar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TYCustomAlignmentDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYCustomAlignmentLabel : UILabel

/**
 * 位移枚举值，默认值TYTextAlignmentTopLeft
 */
@property (nonatomic, assign) TYTextAlignment customAlignment;

@end

NS_ASSUME_NONNULL_END
