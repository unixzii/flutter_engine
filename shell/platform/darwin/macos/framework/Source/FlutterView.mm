// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "flutter/shell/platform/darwin/macos/framework/Source/FlutterView.h"

@interface FlutterView () <MTKViewDelegate>
@end

@implementation FlutterView {
  __weak id<FlutterViewReshapeListener> _reshapeListener;
}

static void CommonInit(FlutterView* view) {
  view.paused = YES;
  view.delegate = view;
}

- (instancetype)initWithFrame:(NSRect)frame
              reshapeListener:(id<FlutterViewReshapeListener>)reshapeListener {
  self = [super initWithFrame:frame device:MTLCreateSystemDefaultDevice()];
  if (self) {
    _reshapeListener = reshapeListener;
    CommonInit(self);
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  CommonInit(self);
  return self;
}

- (instancetype)initWithFrame:(NSRect)frame device:(id<MTLDevice>)device {
  self = [super initWithFrame:frame device:device];
  CommonInit(self);
  return self;
}

#pragma mark - NSView overrides

/**
 * Declares that the view uses a flipped coordinate system, consistent with Flutter conventions.
 */
- (BOOL)isFlipped {
  return YES;
}

- (BOOL)isOpaque {
  return YES;
}

- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
  [_reshapeListener viewDidReshape:self];
}

- (void)drawInMTKView:(MTKView *)view {
  // Do nothing but wait for the content to be drawn...
}

- (BOOL)acceptsFirstResponder {
  return YES;
}

@end
