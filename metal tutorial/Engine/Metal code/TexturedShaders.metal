//
//  TexturedPlane.metal
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

#include <metal_stdlib>
#include "Constants.metal"
using namespace metal;

struct TxVertexIn {
    float4 position [[ attribute(0) ]];
    float2 textureCoord [[ attribute(1) ]];
};

struct TxVertexOut {
    float4 position [[ position ]];
    float2 textureCoord;
};

vertex TxVertexOut textured_vertex_shader(const TxVertexIn vertexIn [[ stage_in ]], constant ModelConstants &modelConstants [[ buffer(1) ]], constant SceneConstants &sceneConstants [[ buffer(2) ]]) {
    TxVertexOut res;
    res.position = sceneConstants.projectionMatrix * modelConstants.modelViewMatrix * vertexIn.position;
    res.textureCoord = vertexIn.textureCoord;
    return res;
}

fragment float4 textured_fragment_shader(TxVertexOut vertexIn [[ stage_in ]], sampler sampler2d [[ sampler(0) ]], texture2d<float> texture [[ texture(0) ]]) {
    float4 color = texture.sample(sampler2d, vertexIn.textureCoord);
    if (color.a == 0) discard_fragment();
    return color;
}

fragment float4 masked_textured_fragment_shader(TxVertexOut vertexIn [[ stage_in ]], sampler sampler2d [[ sampler(0) ]], texture2d<float> texture [[ texture(0) ]], texture2d<float> mask [[ texture(1) ]]) {
    float4 maskColor = mask.sample(sampler2d, vertexIn.textureCoord);
    if (maskColor.a < 0.5) { discard_fragment(); }
    return texture.sample(sampler2d, vertexIn.textureCoord);
}
