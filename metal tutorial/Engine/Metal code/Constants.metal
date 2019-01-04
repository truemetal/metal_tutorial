//
//  Constants.metal
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct RenderConstants {
    float xOffset;
};

struct ModelConstants {
    float4x4 modelViewMatrix;
};

struct SceneConstants {
    float4x4 projectionMatrix;
};
