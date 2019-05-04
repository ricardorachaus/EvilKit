//
//  EKSpriteNode.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import Foundation

import SpriteKit

open class EKSpriteNode: EKNode {

    /**
     Texture to be drawn (is stretched to fill the sprite)
     */
    open var texture: EKTexture?


    /**
     Texture to use for generating normals that lights use to light this sprite.

     This will only be used if the sprite is lit by at least one light.

     @see EKLightNode
     @see lightingBitMaEK
     */
    open var normalTexture: EKTexture?

    /**
     Base color for the sprite (If no texture is present, the color still is drawn)
     */
    open var color: NSColor


    /**
     Used to choose the location in the sprite that maps to its 'position' in the parent's coordinate space. The valid interval for each input is from 0.0 up to and including 1.0.
     */
    open var anchorPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)


    /**
     Set the size of the sprite (in parent's coordinate space)
     */
    open var size: CGSize

    /**
     Designated Initializer
     Initialize a sprite with a color and the specified bounds.
     @param texture the texture to use (can be nil for colored sprite)
     @param color the color to use for tinting the sprite.
     @param size the size of the sprite in points
     */
    public init(texture: EKTexture?, color: NSColor, size: CGSize) {
        self.texture = texture
        self.color = color
        self.size = size
        super.init()
    }

    /**
     Create a sprite with an EKTexture and the specified size.
     @param texture the texture to reference for size and content
     @param size the size of the sprite in points
     */
    public convenience init(texture: EKTexture?, size: CGSize) {
        self.init(texture: texture, color: .clear, size: size)
    }

    /**
     Initialize a sprite with an EKTexture and set its size to the EKTexture's width/height.
     @param texture the texture to reference for size and content
     */
    public convenience init(texture: EKTexture?) {
        let size = texture?.size() == nil ? CGSize.zero : texture!.size()
        self.init(texture: texture, color: .clear, size: size)
    }

    /**
     Initialize a sprite with an image from your app bundle (An EKTexture is created for the image and set on the sprite. Its size is set to the EKTexture's pixel width/height)
     The position of the sprite is (0, 0) and the texture anchored at (0.5, 0.5), so that it is offset by half the width and half the height.
     Thus the sprite has the texture centered about the position. If you wish to have the texture anchored at a different offset set the anchorPoint to another pair of values in the interval from 0.0 up to and including 1.0.
     @param name the name or path of the image to load.
     */
    public convenience init(imageNamed name: String) {
        let texture = EKTexture(imageNamed: name)
        self.init(texture: texture, color: .clear, size: texture.size())
    }

    /**
     Support coding and decoding via NEKeyedArchiver.
     */
    public required init?(coder aDecoder: NSCoder) {
        self.color = .clear
        self.size = CGSize.zero
        super.init(coder: aDecoder)
    }

    /**
     Adjust the sprite's xScale & yScale to achieve the desired size (in parent's coordinate space)
     */
    @available(OSX 10.12, *)
    open func scale(to size: CGSize) {
        xScale = size.width
        yScale = size.height
    }

    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        texture?.render(renderCommandEncoder: renderCommandEncoder)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }

}
