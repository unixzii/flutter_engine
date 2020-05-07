// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Cocoa/Cocoa.h>
#import <MetalKit/MetalKit.h>

/**
 * Listener for view resizing.
 */
@protocol FlutterViewReshapeListener <NSObject>
/**
 * Called when the view's backing store changes size.
 */
- (void)viewDidReshape:(nonnull NSView*)view;
@end

/**
 * View capable of acting as a rendering target and input source for the Flutter
 * engine.
 */
@interface FlutterView : MTKView

- (nullable instancetype)initWithFrame:(NSRect)frame
                       reshapeListener:(nonnull id<FlutterViewReshapeListener>)reshapeListener
    NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithCoder:(nonnull NSCoder *)coder NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithFrame:(NSRect)frame device:(nullable id<MTLDevice>)device NS_DESIGNATED_INITIALIZER;

@end
