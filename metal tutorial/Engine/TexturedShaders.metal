//
//  TexturedPlane.metal
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 1/2/19.
//  Copyright © 2019 iOS-engineer. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct TexturedVertexIn {
    float4 position [[ attribute(0) ]];
    float2 textureCoord [[ attribute(1) ]];
};

struct TexturedVertexOut {
    float4 position [[ position ]];
    float2 textureCoord;
};

vertex TexturedVertexOut noop_textured_vertex_shader(const TexturedVertexIn vertexIn [[ stage_in ]],
                                    uint vertexId [[ vertex_id ]]) {
    TexturedVertexOut res;
    res.position = vertexIn.position;
    res.textureCoord = vertexIn.textureCoord;
    return res;
}

fragment float4 textured_fragment_shader(TexturedVertexOut vertexIn [[ stage_in ]], sampler sampler2d [[ sampler(0) ]], texture2d<float> texture [[ texture(0) ]]) {
    return texture.sample(sampler2d, vertexIn.textureCoord);
}
