//
//  AppyGradientView.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

open class AppyGradientView: AppyView {
    
    // MARK: - Properties
    @IBInspectable public var startColor: UIColor = .clear
    @IBInspectable public var startColorAlpha: CGFloat = 1
    @IBInspectable public var endColor: UIColor = .clear
    @IBInspectable public var endColorAlpha: CGFloat = 1
    @IBInspectable public var gradientType: Int = 0
    
    // MARK: - Life Cycle
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    convenience public init(frame: CGRect, configuration: GradientConfiguration) {
        self.init(frame: frame)
        
        startColor = configuration.startColor
        endColor = configuration.endColor
        gradientType = configuration.behavior.rawValue
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Functions
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        // Color Declarations with Alpha Components
        let startingColor = startColor.withAlphaComponent(startColorAlpha)
        let endingColor = endColor.withAlphaComponent(endColorAlpha)
        
        // Gradient Declarations
        let gradient = CGGradient(colorsSpace: nil, colors: [startingColor.cgColor, endingColor.cgColor] as CFArray, locations: [0, 1])!
        
        // GradientType Declarations
        guard let currentBehavior = GradientBehavior(rawValue: gradientType) else { return }
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(gradient,
                                   start: currentBehavior.locations(for: frame).start,
                                   end: currentBehavior.locations(for: frame).end,
                                   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()
    }
}

extension AppyGradientView: Shiftable {
    
    // Typealiases
    public typealias BehaviorType = GradientBehavior
    public typealias ObjectType = NSNull
}

public extension AppyGradientView {
    
    enum GradientBehavior: Int, Behavior {
        case horizontal = 0, vertical = 1, cross = 2
        
        func locations(for frame: CGRect) -> (start: CGPoint, end: CGPoint) {
            let width = frame.width
            let height = frame.height
            let halfWidth = frame.width / 2.0
            let halfHeight = frame.height / 2.0
            
            switch self {
            case .horizontal: return (CGPoint(x: 0.0, y: halfHeight), CGPoint(x: width, y: halfHeight))
            case .vertical: return (CGPoint(x: halfWidth, y: 0.0), CGPoint(x: halfWidth, y: height))
            case .cross: return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: width, y: height))
            }
        }
    }
    
    public struct GradientConfiguration {
        public var startColor: UIColor
        public var endColor: UIColor
        public var behavior: GradientBehavior
        
        public static var `default`: GradientConfiguration {
            let startColor = UIColor(red: 0.19, green: 0.14, blue: 0.68, alpha: 1.00)
            let endColor = UIColor(red: 0.79, green: 0.43, blue: 0.85, alpha: 1.00)
            
            return GradientConfiguration(startColor: startColor, endColor: endColor, behavior: .horizontal)
        }
    }
}
