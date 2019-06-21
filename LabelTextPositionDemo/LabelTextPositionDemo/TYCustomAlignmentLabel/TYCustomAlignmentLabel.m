//
//  TYCustomAlignmentLabel.m
//  LabelTextPositionDemo
//
//  Created by Kystar on 2019/6/18.
//  Copyright © 2019 kystar. All rights reserved.
//

#import "TYCustomAlignmentLabel.h"



@implementation TYCustomAlignmentLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.customAlignment = TYTextAlignmentTopLeft;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    if (self.customAlignment & TYTextAlignmentVerTop) {
        textRect.origin.y = bounds.origin.y;
        
    }
    else if (self.customAlignment & TYTextAlignmentVerCenter) {
        textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height)/ 2.0;
    }
    else if (self.customAlignment & TYTextAlignmentVerBottom) {
        textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
        
    }
    else {
         textRect.origin.y = bounds.origin.y;
        
    }
    
    if (self.customAlignment & TYTextAlignmentHorLeft) {
        textRect.origin.x = bounds.origin.x;
    }
    else if (self.customAlignment & TYTextAlignmentHorCenter) {
        textRect.origin.x = bounds.origin.x + (bounds.size.width - textRect.size.width) / 2.0;
    }
    else if (self.customAlignment & TYTextAlignmentHorRight) {
        textRect.origin.x = bounds.origin.x + bounds.size.width - textRect.size.width;
    }
    else {
        textRect.origin.x = bounds.origin.x;
    }

    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    printf(__FUNCTION__);
    printf("\n");
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone {
    TYCustomAlignmentLabel *label = [[[self class] allocWithZone:zone] initWithFrame:self.frame];
    label.textColor = self.textColor;
    label.numberOfLines = self.numberOfLines;
    label.font = self.font;
    label.text = self.text;
    label.customAlignment = self.customAlignment;
    label.backgroundColor = self.backgroundColor;
    
    return label;
}


#pragma mark - Private Method


#pragma mark - Setter
- (void)setCustomAlignment:(TYTextAlignment)customAlignment {
    _customAlignment = customAlignment;
    
    [self setNeedsDisplay];
}


@end
