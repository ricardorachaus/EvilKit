//
//  DefaultShaders.metal
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

#include <metal_stdlib>
#include "DefaultTypes.metal"

using namespace metal;

vertex RasterizerData default_vertex_shader(const Vertex in [[ stage_in ]],
                                            constant Scene &scene [[ buffer(1) ]],
                                            constant Model &model [[ buffer(2) ]]) {
    RasterizerData data;

    data.position = scene.projectionMatrix * scene.viewMatrix * model.matrix * float4(in.position, 1);
    data.color = in.color;
    data.textureCoordinate = in.textureCoordinate;

    return data;
}

fragment half4 default_fragment_shader(RasterizerData data [[ stage_in ]],
                                       constant Material &material [[ buffer(1) ]],
                                       sampler sampler2d [[ sampler(0) ]],
                                       texture2d<float> texture [[ texture(0) ]]) {
    float2 textureCoordinate = data.textureCoordinate;
    float4 color;

    if (material.useTexture) {
        color = texture.sample(sampler2d, textureCoordinate);
    } else if (material.useColor) {
        color = material.color;
    } else {
        color = data.color;
    }

    return half4();
}
