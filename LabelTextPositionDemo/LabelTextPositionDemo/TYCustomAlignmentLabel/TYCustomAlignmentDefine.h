//
//  TYCustomAlignmentDefine.h
//  PTwo
//
//  Created by Kystar on 2019/6/18.
//  Copyright © 2019 kystar. All rights reserved.
//

#ifndef TYCustomAlignmentDefine_h
#define TYCustomAlignmentDefine_h

typedef NS_OPTIONS(NSUInteger, TYTextAlignment) {
    TYTextAlignmentHorLeft = 1 << 0,
    TYTextAlignmentHorRight= 1 << 1,
    TYTextAlignmentHorCenter = 1 << 2,
    TYTextAlignmentVerTop = 1 << 5,
    TYTextAlignmentVerBottom = 1 << 6,
    TYTextAlignmentVerCenter = 1 << 7,
    
    
    TYTextAlignmentTopLeft = TYTextAlignmentVerTop | TYTextAlignmentHorLeft,
    TYTextAlignmentTopCenter = TYTextAlignmentVerTop | TYTextAlignmentHorCenter,
    TYTextAlignmentTopRight = TYTextAlignmentVerTop | TYTextAlignmentHorRight,
    
    TYTextAlignmentBottomLeft = TYTextAlignmentVerBottom | TYTextAlignmentHorLeft,
    TYTextAlignmentBottomCenter = TYTextAlignmentVerBottom | TYTextAlignmentHorCenter,
    TYTextAlignmentBottomRight = TYTextAlignmentVerBottom | TYTextAlignmentHorRight,
    
    TYTextAlignmentCenterLeft = TYTextAlignmentVerCenter | TYTextAlignmentHorLeft,
    TYTextAlignmentCenter = TYTextAlignmentVerCenter | TYTextAlignmentHorCenter,
    TYTextAlignmentCenterRight = TYTextAlignmentVerCenter | TYTextAlignmentHorRight,
    
    
};

#endif /* TYCustomAlignmentDefine_h */
