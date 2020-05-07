// Copyright 2020 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef FLUTTER_SHELL_PLATFORM_EMBEDDER_EMBEDDER_SURFACE_METAL_H_
#define FLUTTER_SHELL_PLATFORM_EMBEDDER_EMBEDDER_SURFACE_METAL_H_

#include "flutter/fml/macros.h"
#include "flutter/shell/platform/embedder/embedder_external_view_embedder.h"
#include "flutter/shell/platform/embedder/embedder_surface.h"

namespace flutter {

class EmbedderSurfaceMetal final : public EmbedderSurface {
 public:
  EmbedderSurfaceMetal(void* metal_layer);

  ~EmbedderSurfaceMetal() override;

 private:
  bool valid_ = false;
  void* metal_layer_;

  // |EmbedderSurface|
  bool IsValid() const override;

  // |EmbedderSurface|
  std::unique_ptr<Surface> CreateGPUSurface() override;

  // |EmbedderSurface|
  sk_sp<GrContext> CreateResourceContext() const override;

  FML_DISALLOW_COPY_AND_ASSIGN(EmbedderSurfaceMetal);
};

}  // namespace flutter

#endif  // FLUTTER_SHELL_PLATFORM_EMBEDDER_EMBEDDER_SURFACE_METAL_H_
