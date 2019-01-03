//
//  Shader.metal
//  metal tutorial
//
//  Created by Bogdan Pashchenko on 11/9/18.
//  Copyright © 2018 iOS-engineer. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct RenderConstants {
    float xOffset;
};

struct VertexIn {
    float4 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
};

vertex VertexOut noop_vertex_shader(const VertexIn vertexIn [[ stage_in ]]) {
    VertexOut res;
    res.position = vertexIn.position;
    res.color = vertexIn.color;
    return res;
}

vertex VertexOut animate_vertex_shader(const VertexIn vertexIn [[ stage_in ]],
                                    constant RenderConstants &constants [[ buffer(1) ]],
                                    uint vertexId [[ vertex_id ]]) {
    VertexOut res;
    res.position = vertexIn.position;
    res.position.x += constants.xOffset;
    res.color = vertexIn.color;
    
    return res;
}

vertex VertexOut color_move_vertex_shader(const VertexIn vertexIn [[ stage_in ]],
                                          constant RenderConstants &constants [[ buffer(1) ]],
                                          uint vertexId [[ vertex_id ]]) {
    VertexOut res;
    res.position = vertexIn.position;
    res.color = vertexIn.color;
    
    switch (vertexId) {
        case 0: res.color[0] += constants.xOffset / 2;
        case 1: res.color[1] -= constants.xOffset / 2;
        case 2: res.color[2] += constants.xOffset / 2;
        case 3: res.color[1] += constants.xOffset / 2;
        default: break;
    }
    return res;
}

fragment half4 noop_fragment_shader(VertexOut vertexIn [[ stage_in ]]) {
    return half4(vertexIn.color);
}

fragment half4 grayscale_fragment_shader(VertexOut vertexIn [[ stage_in ]]) {
    float gray = (vertexIn.color[0] + vertexIn.color[1] + vertexIn.color[2]) / 3;
    return half4(gray, gray, gray, 1);
}
