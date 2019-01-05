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
    float4 materialColor;
    float3x3 normalMatrix;
    float specularIntensity;
    float shininess;
};

struct SceneConstants {
    float4x4 projectionMatrix;
};

struct VertexIn {
    float4 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
    float2 textureCoord [[ attribute(2) ]];
    float3 normal [[ attribute(3) ]];
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
    float2 textureCoord;
    float4 materialColor;
    float3 normal;
    float specularIntensity;
    float shininess;
    float3 eyePosition;
};

struct Light {
    float3 color;
    float ambientLightIntensity;
    float3 direction;
    float diffuseIntensity;
};

inline VertexOut vertex_function(const VertexIn vertexIn, constant ModelConstants &modelConstants, constant SceneConstants &sceneConstants) {
    VertexOut res;
    res.position = sceneConstants.projectionMatrix * modelConstants.modelViewMatrix * vertexIn.position;
    res.color = vertexIn.color;
    res.textureCoord = vertexIn.textureCoord;
    res.materialColor = modelConstants.materialColor;
    res.normal = modelConstants.normalMatrix * vertexIn.normal;
    res.specularIntensity = modelConstants.specularIntensity;
    res.shininess = modelConstants.shininess;
    res.eyePosition = (modelConstants.modelViewMatrix * vertexIn.position).xyz;
    return res;
}

vertex VertexOut vertex_shader(const VertexIn vertexIn [[ stage_in ]], constant ModelConstants &modelConstants [[ buffer(1) ]], constant SceneConstants &sceneConstants [[ buffer(2) ]]) {
    return vertex_function(vertexIn, modelConstants, sceneConstants);
}

vertex VertexOut instance_vertex_shader(const VertexIn vertexIn [[ stage_in ]], constant ModelConstants *instanceConstants [[ buffer(1) ]], constant SceneConstants &sceneConstants [[ buffer(2) ]], uint instanceId [[ instance_id ]]) {
    return vertex_function(vertexIn, instanceConstants[instanceId], sceneConstants);
}

inline half4 lit_color(float4 color, VertexOut vertexIn, constant Light &light) {
    // light
    float3 normal = normalize(vertexIn.normal);
    float diffuseFactor = saturate(-dot(light.direction, normal));
    float3 diffuseLight = light.color * light.diffuseIntensity * diffuseFactor;
    float3 ambientLight = light.color * light.ambientLightIntensity;
    
    float3 reflection = reflect(light.direction, normal);
    float3 specularFactor = pow(saturate(-dot(normalize(vertexIn.eyePosition), reflection)), vertexIn.shininess);
    float3 specularLight = light.color * vertexIn.specularIntensity * specularFactor;
    return half4(color * float4(ambientLight + diffuseLight + specularLight, 1));
}

fragment half4 lit_textured_fragment_shader(VertexOut vertexIn [[ stage_in ]], sampler sampler2d [[ sampler(0) ]], texture2d<float> texture [[ texture(0) ]], constant Light &light [[ buffer(0) ]]) {
    float4 color = vertexIn.materialColor * texture.sample(sampler2d, vertexIn.textureCoord);
    if (color.a == 0) discard_fragment();
    
    return lit_color(color, vertexIn, light);
}

//fragment float4 textured_fragment_shader(VertexOut vertexIn [[ stage_in ]], sampler sampler2d [[ sampler(0) ]], texture2d<float> texture [[ texture(0) ]]) {
//    float4 color = texture.sample(sampler2d, vertexIn.textureCoord);
//    if (color.a == 0) discard_fragment();
//    return color * vertexIn.materialColor;
//}
//
//fragment float4 masked_textured_fragment_shader(VertexOut vertexIn [[ stage_in ]], sampler sampler2d [[ sampler(0) ]], texture2d<float> texture [[ texture(0) ]], texture2d<float> mask [[ texture(1) ]]) {
//    float4 maskColor = mask.sample(sampler2d, vertexIn.textureCoord);
//    if (maskColor.a < 0.5) { discard_fragment(); }
//    return texture.sample(sampler2d, vertexIn.textureCoord) * vertexIn.materialColor;
//}

fragment half4 lit_vertex_color_fragment_shader(VertexOut vertexIn [[ stage_in ]], constant Light &light [[ buffer(0) ]]) {
    return lit_color(vertexIn.color, vertexIn, light);
}

fragment half4 lit_material_color_fragment_shader(VertexOut vertexIn [[ stage_in ]], constant Light &light [[ buffer(0) ]]) {
    return lit_color(vertexIn.materialColor, vertexIn, light);
}

fragment half4 non_lit_vertex_color_fragment_shader(VertexOut vertexIn [[ stage_in ]], constant Light &light [[ buffer(0) ]]) {
    return half4(vertexIn.color);
}

fragment half4 non_lit_material_color_fragment_shader(VertexOut vertexIn [[ stage_in ]], constant Light &light [[ buffer(0) ]]) {
    return half4(vertexIn.materialColor);
}

//fragment half4 grayscale_fragment_shader(VertexOut vertexIn [[ stage_in ]]) {
//    float gray = (vertexIn.color[0] + vertexIn.color[1] + vertexIn.color[2]) / 3;
//    return half4(gray, gray, gray, 1);
//}
