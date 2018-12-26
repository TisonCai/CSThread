//
//  CSThread.h
//  threadDemo
//
//  Created by ccs on 2018/12/24.
//  Copyright © 2018年 ccs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSThread : NSObject
- (instancetype)initWithName:(NSString *)name;
- (void)start;
- (void)stop;
- (BOOL)isStart;
- (BOOL)isCurrentThread;

- (void)asyncPerformBlock:(void(^)(void))block;
- (void)syncPerformBlock:(void(^)(void))block;
@end
