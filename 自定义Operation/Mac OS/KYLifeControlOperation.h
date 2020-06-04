//
//  KYLifeControlOperation.h
//  KYControllerMac
//
//  Created by Kystar on 2019/12/2.
//  Copyright © 2019 Telly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KYLifeControlOperation : NSOperation

/**
 * 超时时间，默认30秒
 */
@property (assign) NSTimeInterval timeout;

//重写的任务执行流程的相关变量
@property (assign) BOOL customFinished;
@property (assign) BOOL customExcuting;

/**
 * 设置当前状态为正在执行
 */
- (void)setupCustomExcutingStatus;

/**
 * 执行任务主体
 */
- (void)startCarryOutTask;

/**
 * 触发延时执行超时逻辑
 */
- (void)triggerDelayEndTaskByTimeout;

/**
 * 取消延时执行超时逻辑
 */
- (void)cancelDelayEndTaskByTimeout;

/**
 * 超时导致任务终止
 */
- (void)endTaskByTimeout;

//结束任务
- (void)endExecution;
@end

NS_ASSUME_NONNULL_END
