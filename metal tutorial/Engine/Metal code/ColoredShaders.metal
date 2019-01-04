//
//  Shader.metal
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 11/9/18.
//  Copyright © 2018 iOS-engineer. All rights reserved.
//

#include <metal_stdlib>
#include "Constants.metal"
using namespace metal;

struct VertexIn {
    float4 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
};

vertex VertexOut noop_vertex_shader(const VertexIn vertexIn [[ stage_in ]], constant ModelConstants &modelConstants [[ buffer(1) ]], constant SceneConstants &sceneConstants [[ buffer(2) ]]) {
    VertexOut res;
    res.position = sceneConstants.projectionMatrix * modelConstants.modelViewMatrix * vertexIn.position;
    res.color = vertexIn.color;
    return res;
}

fragment half4 noop_fragment_shader(VertexOut vertexIn [[ stage_in ]]) {
    return half4(vertexIn.color);
}

fragment half4 grayscale_fragment_shader(VertexOut vertexIn [[ stage_in ]]) {
    float gray = (vertexIn.color[0] + vertexIn.color[1] + vertexIn.color[2]) / 3;
    return half4(gray, gray, gray, 1);
}
