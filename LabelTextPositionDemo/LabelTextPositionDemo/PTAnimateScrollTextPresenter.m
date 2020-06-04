//
//  PTAnimateScrollTextPresenter.m
//  LabelTextPositionDemo
//
//  Created by Kystar on 2019/6/20.
//  Copyright © 2019 kystar. All rights reserved.
//

#import "PTAnimateScrollTextPresenter.h"


@interface PTAnimateScrollTextPresenter() {
    
    
    //文字的rect
    CGRect _textRect;
    //动画元素之间的间距
    CGFloat _itemSpacing;
    //动画幕布裁剪宽度
    CGFloat _animateScreenClippedWidth;
    //动画幕布裁剪高度
    CGFloat _animateScreenClippedHeight;
    
    CADisplayLink *_displayLink;
}


@property (nonatomic, strong) NSArray <UILabel *>*animateLabelArray;

@end



@implementation PTAnimateScrollTextPresenter

static PTAnimateScrollTextPresenter *_sharedInstance = nil;
+ (instancetype)pt_sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_sharedInstance == nil) {
            _sharedInstance = [[PTAnimateScrollTextPresenter alloc] init];
        }
        
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scale = 0.209;
        self.scrollStep = 3;
        self.scrollType = PTTextScrollTypeLeftToRight;
        self.annular = YES;
    }
    
    return self;
}



#pragma mark - Event Response
- (void)ty_displayLinkHandleAction:(CADisplayLink *)displayLink {
    
    PTTextScrollType scrollType = self.scrollType;
    CGFloat scrollStep = self.scrollStep * self.scale;
    
    
    for (int i = 0; i < self.animateLabelArray.count; i ++) {
        UILabel *preLabel;
        
        UILabel *currentLabel = self.animateLabelArray[i];
        
        if (scrollType == PTTextScrollTypeRightToLeft) {
            if (i == 0) {
                preLabel = [self.animateLabelArray lastObject];
            }
            else {
                preLabel = self.animateLabelArray[i - 1];
            }
            
            CGFloat left = currentLabel.ty_left - scrollStep;
            if (left < -currentLabel.ty_width) {
                left = preLabel.ty_right - scrollStep + _itemSpacing;
//                NSLog(@"left >>> %f", left);
            }
            
            currentLabel.ty_left = left;
        }
        else if (scrollType == PTTextScrollTypeLeftToRight) {
            
            if (i == self.animateLabelArray.count - 1) {
                preLabel = [self.animateLabelArray firstObject];
            }
            else {
                preLabel = self.animateLabelArray[i + 1];
            }
            
            CGFloat left = currentLabel.ty_left + scrollStep;
            if (left > _animateScreenClippedWidth) {
                left = preLabel.ty_left + scrollStep - _itemSpacing - currentLabel.ty_width;
//                NSLog(@"left >>> %f", left);
            }
            
            currentLabel.ty_left = left;
        }
        else if (scrollType == PTTextScrollTypeBottomToTop) {
            if (i == 0) {
                preLabel = [self.animateLabelArray lastObject];
            }
            else {
                preLabel = self.animateLabelArray[i - 1];
            }
            
            CGFloat top = currentLabel.ty_top - scrollStep;
            if (top < -currentLabel.ty_height) {
                top = preLabel.ty_bottom - scrollStep + _itemSpacing;
//                NSLog(@"top >>> %f", top);
            }
            
            currentLabel.ty_top = top;
            
        }
        else if (scrollType == PTTextScrollTypeTopToBottom) {
            if (i == self.animateLabelArray.count - 1) {
                preLabel = [self.animateLabelArray firstObject];
            }
            else {
                preLabel = self.animateLabelArray[i + 1];
            }
            
            CGFloat top = currentLabel.ty_top + scrollStep;
            if (top > _animateScreenClippedHeight) {
                top = preLabel.ty_top + scrollStep - _itemSpacing - currentLabel.ty_height;
//                NSLog(@"top >>> %f", top);
            }
            
            currentLabel.ty_top = top;
        }
        
        
    }
    
    
}

#pragma mark - Private Method

//animate
- (void)pt_startAnimateWithScrollType:(PTTextScrollType)scrollType {
    
    [self pt_startAnimateWithScrollType:scrollType annular:self.annular scrollStep:self.scrollStep originLabel:nil];
}

- (void)pt_startAnimateWithAnnular:(BOOL)annular {
    
    [self pt_startAnimateWithScrollType:self.scrollType annular:annular scrollStep:self.scrollStep originLabel:nil];

}

- (void)pt_startAnimateWithScrollStep:(CGFloat)scrollStep {
    
    [self pt_startAnimateWithScrollType:self.scrollType annular:self.annular scrollStep:scrollStep originLabel:nil];
    
}

- (void)pt_startAnimateWithOriginLabel:(UILabel<NSCopying> *)originLabel {
    [self pt_startAnimateWithScrollType:self.scrollType annular:self.annular scrollStep:self.scrollStep originLabel:originLabel];
}

- (void)pt_startAnimateWithScrollType:(PTTextScrollType)scrollType annular:(BOOL)annular scrollStep:(CGFloat)scrollStep originLabel:(UILabel<NSCopying> * _Nullable )originLabel {
    self.scrollType = scrollType;
    self.annular = annular;
    self.scrollStep = scrollStep;
    
    if (originLabel != nil) {
        
        self.originLabel = originLabel;
    }
    
    //静止状态 隐藏多余的label，复位源label，暂停定时器
    if (self.scrollType == PTTextScrollTypeStatic) {
        [self pt_resetAnimateLabelsFrameAtStatic];
        [self pt_configDisplayLinkAtStatic];
    }
    else{
        [self pt_resetAnimateLabelsFrame];
        [self pt_configDisplayLink];
    
    }
    
}

//重置h动画label数组
- (void)pt_resetAnimateLabelArray {
    
    for (UILabel *label in self.animateLabelArray) {
        if (label != self.originLabel) {
            label.hidden = YES;
            [label removeFromSuperview];
        }
        
    }
    
    UILabel *headLabel = [self.originLabel copy];
    headLabel.ty_right = self.originLabel.ty_left;
    UILabel *tailLabel = [self.originLabel copy];
    tailLabel.ty_left = self.originLabel.ty_right;
    
    _animateLabelArray = @[headLabel, self.originLabel, tailLabel];
    
    [self.originLabel.superview addSubview:headLabel];
    [self.originLabel.superview addSubview:tailLabel];
    
}



- (void)pt_resetAnimateLabelsFrameAtStatic {
    self.originLabel.frame = _originLabelFrame;
    
    for (UILabel *label in self.animateLabelArray) {
        if (label != self.originLabel) {
            label.hidden = YES;
        }
    }
}


//重置所有的label的位置
- (void)pt_resetAnimateLabelsFrame {
    _displayLink.paused = YES;
    
    _animateScreenClippedWidth = self.originLabel.superview.ty_width;
    _animateScreenClippedHeight = self.originLabel.superview.ty_height;
    
    
    CGSize labelAnimateSize = {_textRect.size.width, _textRect.size.height};
    
    
    if (self.annular) {
        if (self.scrollType == PTTextScrollTypeRightToLeft || self.scrollType == PTTextScrollTypeLeftToRight) {
            _itemSpacing = ceil(MAX(60, (self.originLabel.superview.ty_width - _textRect.size.width) / 2));
        }
        else if (self.scrollType == PTTextScrollTypeBottomToTop || self.scrollType == PTTextScrollTypeTopToBottom) {
            _itemSpacing = ceil(MAX(30, (self.originLabel.superview.ty_height - _textRect.size.height) / 2));;
        }
        
        
    }
    else {
        if (self.scrollType == PTTextScrollTypeRightToLeft || self.scrollType == PTTextScrollTypeLeftToRight) {
            _itemSpacing = _animateScreenClippedWidth;
        }
        else if (self.scrollType == PTTextScrollTypeBottomToTop || self.scrollType == PTTextScrollTypeTopToBottom) {
            _itemSpacing = _animateScreenClippedHeight;
        }
    }
    
    
    if (self.scrollType == PTTextScrollTypeLeftToRight) {
        UILabel *currentLabel = nil;
        CGFloat right = 0;
        NSEnumerator *enumerator = self.animateLabelArray.reverseObjectEnumerator;
        while (currentLabel = [enumerator nextObject]) {
        
            currentLabel.ty_top = _originLabelFrame.origin.y;
            currentLabel.ty_width = labelAnimateSize.width;
            currentLabel.ty_height = _originLabelFrame.size.height;
            currentLabel.ty_right = right;
            
            right = right - currentLabel.ty_width - _itemSpacing;
        }
        
    }
    else if (self.scrollType == PTTextScrollTypeRightToLeft) {
        UILabel *currentLabel = nil;
        CGFloat left = _animateScreenClippedWidth;
        NSEnumerator *enumerator = self.animateLabelArray.objectEnumerator;
        while (currentLabel = [enumerator nextObject]) {
            currentLabel.ty_left = left;
            currentLabel.ty_top = _originLabelFrame.origin.y;
            currentLabel.ty_width = labelAnimateSize.width;
            currentLabel.ty_height = _originLabelFrame.size.height;
            left = left + currentLabel.ty_width + _itemSpacing;
        }
    }
    else if (self.scrollType == PTTextScrollTypeTopToBottom) {
        UILabel *currentLabel = nil;
        CGFloat bottom = 0;
        NSEnumerator *enumerator = self.animateLabelArray.reverseObjectEnumerator;
        while (currentLabel = [enumerator nextObject]) {
            currentLabel.ty_left = _originLabelFrame.origin.x;
            currentLabel.ty_width = _originLabelFrame.size.width;
            currentLabel.ty_height = labelAnimateSize.height;
            currentLabel.ty_bottom = bottom;
            
            bottom = bottom - currentLabel.ty_height - _itemSpacing;
        }
        
    }
    else if (self.scrollType == PTTextScrollTypeBottomToTop) {
        UILabel *currentLabel = nil;
        CGFloat top = _animateScreenClippedHeight;
        NSEnumerator *enumerator = self.animateLabelArray.objectEnumerator;
        while (currentLabel = [enumerator nextObject]) {
            currentLabel.ty_left = _originLabelFrame.origin.x;
            currentLabel.ty_top = top;
            currentLabel.ty_width = _originLabelFrame.size.width;
            currentLabel.ty_height = labelAnimateSize.height;
            top = top + currentLabel.ty_height + _itemSpacing;
        }
    }
    
    /*
    {
    self.originLabel.frame = _originLabelFrame;
    NSInteger referIndex = [self.animateLabelArray indexOfObject:self.originLabel];
    for (NSInteger i = referIndex - 1; i >= 0; i --) {
        UILabel *currentLabel = self.animateLabelArray[i];
        currentLabel.hidden = NO;
        
//        currentLabel.ty_size = labelAnimateSize;
        
        if (self.scrollType == PTTextScrollTypeRightToLeft || self.scrollType == PTTextScrollTypeLeftToRight) {
            currentLabel.ty_right = self.animateLabelArray[i + 1].ty_left - _itemSpacing;
            currentLabel.ty_top = _originLabel.ty_top;
        }
        else if (self.scrollType == PTTextScrollTypeBottomToTop || self.scrollType == PTTextScrollTypeTopToBottom) {
            currentLabel.ty_left = _originLabel.ty_left;
            currentLabel.ty_bottom = self.animateLabelArray[i + 1].ty_top - _itemSpacing;
            
        }
        
        
    }
    
    for (NSInteger i = referIndex + 1; i < self.animateLabelArray.count; i ++) {
        UILabel *currentLabel = self.animateLabelArray[i];
        currentLabel.hidden = NO;
        
//        currentLabel.ty_size = labelAnimateSize;
        
        if (self.scrollType == PTTextScrollTypeRightToLeft || self.scrollType == PTTextScrollTypeLeftToRight) {
            currentLabel.ty_left = self.animateLabelArray[i - 1].ty_right + _itemSpacing;
            currentLabel.ty_top = _originLabel.ty_top;
        }
        else if (self.scrollType == PTTextScrollTypeBottomToTop || self.scrollType == PTTextScrollTypeTopToBottom) {
            
            currentLabel.ty_left = _originLabel.ty_left;
            currentLabel.ty_top = self.animateLabelArray[i - 1].ty_bottom + _itemSpacing;
            
        }
        
    }
    
    }
    */
}


- (void)pt_configDisplayLinkAtStatic {
     _displayLink.paused = YES;
}

//配置CADisplayLink 动画定时器
- (void)pt_configDisplayLink {
  
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(ty_displayLinkHandleAction:)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    else {
        if (_displayLink.paused) {
            _displayLink.paused = NO;
        }
    }
    
    
}

- (void)ty_stopAnimate {
    [self pt_resetAnimateLabelsFrameAtStatic];
    
    [_displayLink invalidate];
    _displayLink = nil;
}



#pragma mark - Getter


#pragma mark - Setter
- (void)setOriginLabel:(UILabel<NSCopying> *)originLabel {
    _originLabel = originLabel;
    _originLabelFrame = _originLabel.frame;

    _textRect = [_originLabel textRectForBounds:_originLabel.bounds limitedToNumberOfLines:_originLabel.numberOfLines];
    
    [self pt_resetAnimateLabelArray];
}
@end
