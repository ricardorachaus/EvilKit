//
//  DefaultShaders.metal
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct EKVertex {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
    float2 textureCoordinate [[ attribute(2) ]];
};

struct EKRasterizerData {
    float4 position [[ position ]];
    float4 color;
    float2 textureCoordinate;
};

struct EKNodeTransform {
    float4x4 matrix;
};

struct EKSceneTransform {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

struct EKMaterial {
    float4 color;
    bool useMaterialColor;
    bool useTexture;
};

vertex EKRasterizerData default_vertex_shader(const EKVertex in [[ stage_in ]],
                                              constant EKSceneTransform &scene [[ buffer(1) ]],
                                              constant EKNodeTransform &transform [[ buffer(2) ]]){
    EKRasterizerData data;

    data.position = scene.projectionMatrix * scene.viewMatrix * transform.matrix * float4(in.position, 1);
    data.color = in.color;
    data.textureCoordinate = in.textureCoordinate;

    return data;
}

fragment half4 default_fragment_shader(EKRasterizerData data [[ stage_in ]],
                                       constant EKMaterial &material [[ buffer(1) ]],
                                       sampler sampler2d [[ sampler(0) ]],
                                       texture2d<float> texture [[ texture(0) ]]) {
    float2 textureCoordinate = data.textureCoordinate;
    float4 color;

    if (material.useTexture) {
        color = texture.sample(sampler2d, textureCoordinate);
    } else if (material.useMaterialColor) {
        color = material.color;
    } else {
        color = data.color;
    }

    return half4(color.r, color.g, color.b, color.a);
}
