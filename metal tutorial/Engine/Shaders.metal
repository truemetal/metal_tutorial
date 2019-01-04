//
//  Constants.metal
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/3/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct ModelConstants {
    float4x4 modelViewMatrix;
};

struct SceneConstants {
    float4x4 projectionMatrix;
};

struct VertexIn {
    float4 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
    float2 textureCoord [[ attribute(2) ]];
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
    float2 textureCoord;
};

vertex VertexOut vertex_shader(const VertexIn vertexIn [[ stage_in ]], constant ModelConstants &modelConstants [[ buffer(1) ]], constant SceneConstants &sceneConstants [[ buffer(2) ]]) {
    VertexOut res;
    res.position = sceneConstants.projectionMatrix * modelConstants.modelViewMatrix * vertexIn.position;
    res.color = vertexIn.color;
    res.textureCoord = vertexIn.textureCoord;
    return res;
}

fragment float4 textured_fragment_shader(VertexOut vertexIn [[ stage_in ]], sampler sampler2d [[ sampler(0) ]], texture2d<float> texture [[ texture(0) ]]) {
    float4 color = texture.sample(sampler2d, vertexIn.textureCoord);
    if (color.a == 0) discard_fragment();
    return color;
}

fragment float4 masked_textured_fragment_shader(VertexOut vertexIn [[ stage_in ]], sampler sampler2d [[ sampler(0) ]], texture2d<float> texture [[ texture(0) ]], texture2d<float> mask [[ texture(1) ]]) {
    float4 maskColor = mask.sample(sampler2d, vertexIn.textureCoord);
    if (maskColor.a < 0.5) { discard_fragment(); }
    return texture.sample(sampler2d, vertexIn.textureCoord);
}

fragment half4 noop_fragment_shader(VertexOut vertexIn [[ stage_in ]]) {
    return half4(vertexIn.color);
}

fragment half4 grayscale_fragment_shader(VertexOut vertexIn [[ stage_in ]]) {
    float gray = (vertexIn.color[0] + vertexIn.color[1] + vertexIn.color[2]) / 3;
    return half4(gray, gray, gray, 1);
}