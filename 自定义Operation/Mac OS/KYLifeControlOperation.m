//
//  KYLifeControlOperation.m
//  KYControllerMac
//
//  Created by Kystar on 2019/12/2.
//  Copyright © 2019 Telly. All rights reserved.
//

#import "KYLifeControlOperation.h"

@interface KYLifeControlOperation()

@property (assign) BOOL isWaittingTimeout;

@end

@implementation KYLifeControlOperation



#pragma mark - Overload Method
- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeout = 30;
    }
    return self;
}

- (BOOL)isFinished {
    return self.customFinished;
}

- (BOOL)isExecuting {
    return self.customExcuting;
}


#pragma mark - Public Method
- (void)setupCustomExcutingStatus {
    [self willChangeValueForKey:@"executing"];
    self.customExcuting = YES;
    [self didChangeValueForKey:@"executing"];
}

- (void)startCarryOutTask {
//    NSLog(@"开始任务 >>> %@",self);
    if (self.timeout > 0) {
        [self triggerDelayEndTaskByTimeout];
    }
    else {
        [self endExecution];
    }
}

/**
 * 触发延时执行超时逻辑
 */
- (void)triggerDelayEndTaskByTimeout {
    //            NSLog(@"添加延时操作 >>> %@", self);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isWaittingTimeout = YES;
        [self performSelector:@selector(endTaskByTimeout) withObject:nil afterDelay:self.timeout];
    });
    
}
/**
 * 取消延时执行超时逻辑
 */
- (void)cancelDelayEndTaskByTimeout {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isWaittingTimeout) {
            //终止 等待响应的超时操作
            //NSLog(@"取消延时操作 >>> %@", self);
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(endTaskByTimeout) object:nil];
        }
    });
    
}

//超时导致任务终止
- (void)endTaskByTimeout {
    self.isWaittingTimeout = NO;
    [self endExecution];
}

- (void)endExecution {
    [self cancelDelayEndTaskByTimeout];
    
    [self finishExcutingTask];
}

- (void)finishExcutingTask {
    NSLog(@"结束任务 >>> %@", self);
    //任务结束后的关键操作
    [self willChangeValueForKey:@"executing"];
    self.customExcuting = NO;
    [self didChangeValueForKey:@"executing"];

    [self willChangeValueForKey:@"finished"];
    self.customFinished = YES;
    [self didChangeValueForKey:@"finished"];
}
@end
