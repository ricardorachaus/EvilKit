//
//  EKTexture.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import MetalKit

import SpriteKit

open class EKTexture: NSObject {

    /**
     The filtering mode the texture should use when not drawn at native size. Defaults to EKTextureFilteringLinear.
     */
    open var filteringMode: EKTextureFilteringMode {
        willSet {
            setupSampler()
        }
    }

    private var name: String
    private var texture: MTLTexture!
    private var samplerState: MTLSamplerState?
    private let samplerDescriptor: MTLSamplerDescriptor

    private var mesh: EKMesh
    private var material: EKMaterial

    public override init() {
        self.filteringMode = .linear
        self.name = ""
        self.samplerDescriptor = MTLSamplerDescriptor()
        self.mesh = EKQuadMesh()
        self.material = EKMaterial(useTexture: true)
        super.init()
        setupSampler()
    }

    /**
     Create a texture from an image file. Behaves similar to imageNamed: in UIImage or NSImage

     @param name the name or path of the image to load.
     */
    public convenience init(imageNamed name: String) {
        self.init()
        self.name = name
        self.samplerState = GPU.device.makeSamplerState(descriptor: self.samplerDescriptor)
        loadTexture(named: name)
    }

    /**
     Used to choose the area of the texture you want to display. The origin and size should both be in the range 0.0 - 1.0, values outside of this range produces unpredictable results. Defaults to the entire texture {(0,0) (1,1)}.
     */
    open func textureRect() -> CGRect {
        if let texture = texture {
            return CGRect(x: 0,
                          y: 0,
                          width: texture.width,
                          height: texture.height)
        }
        return CGRect.zero
    }


    /**
     The size of the texture's bitmap data in points.
     */
    open func size() -> CGSize {
        if let texture = texture {
            return CGSize(width: texture.width,
                          height: texture.height)
        }
        return CGSize.zero
    }
    
    // MARK: - Render Methods
    
    internal func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setFragmentBytes(&material, length: EKMaterial.stride, index: 1)
        renderCommandEncoder.setFragmentSamplerState(samplerState, index: 0)
        if material.useTexture {
            renderCommandEncoder.setFragmentTexture(texture, index: 0)
        }
        mesh.drawPrimitives(renderCommandEncoder)
    }

    // MARK: - Resource methods

    private func setupSampler() {
        samplerDescriptor.minFilter = filteringMode.samplerFilter()
        samplerDescriptor.magFilter = filteringMode.samplerFilter()
        samplerDescriptor.label = name
        samplerState = GPU.device.makeSamplerState(descriptor: samplerDescriptor)
    }

    private func loadTexture(named: String) {
        let imageNames = named.split(separator: ".")
        if let url = Bundle.main.url(forResource: imageNames[0].description, withExtension: imageNames[1].description) {
            let loader = MTKTextureLoader(device: GPU.device)
            let options: [MTKTextureLoader.Option: MTKTextureLoader.Origin] = [.origin: .bottomLeft]

            do {
                texture = try loader.newTexture(URL: url, options: options)
                texture.label = named
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
