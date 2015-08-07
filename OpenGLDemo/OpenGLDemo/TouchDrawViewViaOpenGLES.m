//
//  TouchDrawViewViaOpenGLES.m
//  OpenGLDemo
//
//  Created by zj-db0352 on 15/8/6.
//  Copyright (c) 2015年 zj-db0352. All rights reserved.
//

#import "TouchDrawViewViaOpenGLES.h"

@implementation TouchDrawViewViaOpenGLES

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _linesCompleted = [[NSMutableArray alloc] init];
        [self setMultipleTouchEnabled:YES];
        [self becomeFirstResponder];
    }

    return self;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)drawRect:(CGRect)rect {
    [self.delegate touchDrawViewViaOpenGLES:_linesCompleted inFrame:self.frame];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - screen touch operations

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    for (UITouch *t in touches) {
        // 获取该touch的point
        CGPoint p = [t locationInView:self];
        Line *l = [[Line alloc] init];
        l.begin = p;
        l.end = p;
        _currentLine = l;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesMoved");
    for (UITouch *t in touches) {
        CGPoint p = [t locationInView:self];
        _currentLine.end = p;

        if (_currentLine) {
            [_linesCompleted addObject:_currentLine];
        }
        Line *l = [[Line alloc] init];
        l.begin = p;
        l.end = p;
        _currentLine = l;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded");
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesCancelled");
    [self setNeedsDisplay];
}

#pragma mark - motion

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionBegan");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionEnded");
    if (motion == UIEventSubtypeMotionShake) {
        [_linesCompleted removeAllObjects];
        [self setNeedsDisplay];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionCancelled");
}

@end
