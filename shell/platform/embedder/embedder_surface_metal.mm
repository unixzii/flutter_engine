// Copyright 2020 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Metal/Metal.h>
#import <QuartzCore/QuartzCore.h>

#include "flutter/shell/platform/embedder/embedder_surface_metal.h"

#include "flutter/shell/common/shell_io_manager.h"
#include "flutter/shell/gpu/gpu_surface_metal.h"

namespace flutter {

EmbedderSurfaceMetal::EmbedderSurfaceMetal(void* metal_layer) {
  valid_ = true;
  metal_layer_ = metal_layer;
}

EmbedderSurfaceMetal::~EmbedderSurfaceMetal() = default;

// |EmbedderSurface|
bool EmbedderSurfaceMetal::IsValid() const {
  return valid_;
}

// |EmbedderSurface|
std::unique_ptr<Surface> EmbedderSurfaceMetal::CreateGPUSurface() {
  auto metal_layer = (CAMetalLayer*) metal_layer_;
  auto device = metal_layer.device;
  auto command_queue = [device newCommandQueue];
  
  auto gr_context = GrContext::MakeMetal(device, command_queue);
  
  return std::make_unique<GPUSurfaceMetal>(nullptr,  // GPU surface GL delegate
                                           fml::scoped_nsobject<CAMetalLayer>(metal_layer),
                                           gr_context,
                                           fml::scoped_nsprotocol<id<MTLCommandQueue>>(command_queue)
  );
}

// |EmbedderSurface|
sk_sp<GrContext> EmbedderSurfaceMetal::CreateResourceContext() const {
  // TODO: Implement this.
  return nullptr;
}

}  // namespace flutter
