//
//  AppyView.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

@IBDesignable
open class AppyView: UIView {
    
    // MARK: - Properties / Border
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var dash: CGFloat = 0.0
    @IBInspectable public var dashGap: CGFloat = 0.0
    @IBInspectable public var isDashed: Bool = false
    
    // MARK: - Properties / Corner
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Properties / Shadow
    @IBInspectable public var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable public var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable public var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isDashed {
            let context = UIGraphicsGetCurrentContext()!
            
            // Dashed Rectangle Drawing
            let dashedRectanglePath = UIBezierPath(roundedRect: CGRect(x: rect.minX + 0.5, y: rect.minY + 0.5, width: rect.width - 1.0, height: rect.height - 1.0), cornerRadius: cornerRadius)
            borderColor.setStroke()
            dashedRectanglePath.lineWidth = 1.0
            context.saveGState()
            context.setLineDash(phase: 0, lengths: [dash, dashGap])
            dashedRectanglePath.stroke()
            context.restoreGState()
        }
    }
}
