//
//  EKTexture.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

open class EKTexture: NSObject {

    open var filteringMode: EKTextureFilteringMode = .linear {
        willSet {
            setupSampler()
        }
    }

    private var name: String
    private var mesh: EKMesh
    private var material: EKMaterial
    private var texture: MTLTexture?
    private var samplerState: MTLSamplerState?
    private var samplerDescriptor: MTLSamplerDescriptor

    public override init() {
        self.name = ""
        self.mesh = EKQuadMesh()
        self.material = EKMaterial(useTexture: true)
        self.samplerDescriptor = MTLSamplerDescriptor()
        super.init()
        setupSampler()
    }

    public convenience init(imageNamed name: String) {
        self.init()
        self.name = name
        self.samplerState = GPU.device.makeSamplerState(descriptor: self.samplerDescriptor)
        loadTexture(named: name)
    }

    internal func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setFragmentBytes(&material, length: EKMaterial.stride, index: 1)
        renderCommandEncoder.setFragmentSamplerState(samplerState, index: 0)
        if let texture = texture,
            material.useTexture {
            renderCommandEncoder.setFragmentTexture(texture, index: 0)
        }
        mesh.drawPrimitives(renderCommandEncoder: renderCommandEncoder)
    }

    private func setupSampler() {
        samplerDescriptor.minFilter = filteringMode.samplerFilter()
        samplerDescriptor.magFilter = filteringMode.samplerFilter()
        samplerDescriptor.label = name
        samplerState = GPU.device.makeSamplerState(descriptor: samplerDescriptor)
    }

    private func loadTexture(named: String) {
        let imageNames = named.split(separator: ".")
        if let imageName = imageNames.first?.description,
            let imageExtension = imageNames.last?.description,
            let url = Bundle.main.url(forResource: imageName, withExtension: imageExtension) {
            let loader = MTKTextureLoader(device: GPU.device)
            let options: [MTKTextureLoader.Option: MTKTextureLoader.Origin] = [.origin: .bottomLeft]
            do {
                texture = try loader.newTexture(URL: url, options: options)
                texture?.label = named
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid file format: \(named)")
        }
    }

}
