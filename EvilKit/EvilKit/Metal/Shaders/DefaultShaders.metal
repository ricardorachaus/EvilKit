//
//  DefaultShaders.metal
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

#include <metal_stdlib>
#include <metal_common>
#include <metal_geometric>
using namespace metal;

struct EKVertex {
    float3 position [[ attribute(0) ]];
    float2 textureCoordinate [[ attribute(1) ]];
};

struct EKRasterizerData {
    float4 position [[ position ]];
    float2 textureCoordinate;
};

struct EKNodeTransform {
    float4x4 modelMatrix;
};

struct EKSceneTransform {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

struct EKMaterial {
    float4 strokeColor;
    float4 fillColor;
    bool useTexture;
    bool isCircular;
};

constant float kAlphaTestReferenceValue = 0.5;

vertex EKRasterizerData default_vertex_shader(const EKVertex in [[ stage_in ]],
                                              constant EKSceneTransform &scene [[ buffer(1) ]],
                                              constant EKNodeTransform &transform [[ buffer(2) ]]){
    EKRasterizerData data;

    data.position = scene.projectionMatrix * scene.viewMatrix * transform.modelMatrix * float4(in.position, 1);
    data.textureCoordinate = in.textureCoordinate;

    return data;
}

fragment half4 default_fragment_shader(EKRasterizerData data [[ stage_in ]],
                                       constant EKMaterial &material [[ buffer(1) ]],
                                       sampler sampler2d [[ sampler(0) ]],
                                       texture2d<float> texture [[ texture(0) ]]) {
    float2 textureCoordinate = data.textureCoordinate;
    float4 color;

    // Circular fragment shader
    if (material.isCircular && !material.useTexture) {
        float radius = 1;
        bool result = radius > dot(textureCoordinate, textureCoordinate);

        if (result) {
            color = material.fillColor;
        } else {
            discard_fragment();
        }
    }

    //
    if (material.useTexture) {
        float4 resultColor = texture.sample(sampler2d, textureCoordinate);
        if (resultColor.a < kAlphaTestReferenceValue) {
            discard_fragment();
        } else {
            color = resultColor;
        }
    } else if (!material.isCircular) {
        color = material.fillColor;
    }

    return half4(color.r, color.g, color.b, color.a);
}
