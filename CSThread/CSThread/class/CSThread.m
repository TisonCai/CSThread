//
//  CSThread.m
//  threadDemo
//
//  Created by ccs on 2018/12/24.
//  Copyright © 2018年 ccs. All rights reserved.
//

#import "CSThread.h"

@interface CSThread()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, assign) BOOL isThreadStart;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CSThread
- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}
#pragma mark - Public
- (void)asyncPerformBlock:(void(^)(void))block {
    [self _performBlock:block isAsync:YES];
}
- (void)syncPerformBlock:(void(^)(void))block {
    [self _performBlock:block isAsync:NO];
}
- (void)start {
    if (_isThreadStart) return;
    
    _isThreadStart = YES;
    [self.thread start];
}
- (void)stop {
    if (!_isThreadStart) return;
    
    _isThreadStart = NO;
    [self.timer invalidate];
    _thread = nil;
    _timer = nil;
}
- (BOOL)isStart {
    return self.isThreadStart;
}
- (BOOL)isCurrentThread {
    return [[NSThread currentThread] isEqual:self.thread];
}
- (void)runLoop {
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }
}
#pragma mark - Private
- (void)_performBlock:(void(^)(void))block isAsync:(BOOL)async{
    if (!_thread)   return;
    [self performSelector:@selector(_runBlock:) onThread:self.thread withObject:block waitUntilDone:!async];
}

- (void)_runBlock:(void(^)(void))block {
    if (block) block();
}
- (void)timeFire {
    NSLog(@"timer fire");
}
#pragma mark - getter
- (NSThread *)thread {
    if (_thread == nil) {
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(runLoop) object:nil];
        [_thread setName:_name];
    }
    return _thread;
}
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:100 target:self selector:@selector(timeFire) userInfo:nil repeats:YES];
    }
    return _timer;
}
@end
