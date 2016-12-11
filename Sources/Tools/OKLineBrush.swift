//
//  OKLineBrush.swift
//  OKKLineSwift
//
//  Created by SHB on 2016/11/29.
//  Copyright © 2016年 Herb. All rights reserved.
//

#if os(macOS)
    import Cocoa
#else
    import UIKit
#endif
import CoreGraphics

class OKLineBrush {
    
    public var indicatorType: OKIndicatorType
    private var configuration: OKConfiguration
    private var context: CGContext
    private var firstValueIndex: Int?
    
    public var calFormula: ((Int, OKKLineModel) -> CGPoint?)?
    
    init(indicatorType: OKIndicatorType, context: CGContext, configuration: OKConfiguration) {
        self.indicatorType = indicatorType
        self.context = context
        self.configuration = configuration
        
        context.setLineWidth(configuration.indicatorLineWidth)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        
        switch indicatorType {
        case .DIF:
            context.setStrokeColor(configuration.theme.DIFColor)
        case .DEA:
            context.setStrokeColor(configuration.theme.DEAColor)
        case .KDJ_K:
            context.setStrokeColor(configuration.theme.KDJ_KColor)
        case .KDJ_D:
            context.setStrokeColor(configuration.theme.KDJ_DColor)
        case .KDJ_J:
            context.setStrokeColor(configuration.theme.KDJ_JColor)
            
        default: break
        }
    }
    
    public func draw(drawModels: [OKKLineModel]) {
        
        for (index, model) in drawModels.enumerated() {
            
            if let point = calFormula?(index, model) {
                
                if firstValueIndex == nil {
                    firstValueIndex = index
                }
                
                if firstValueIndex == index {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
        }
        context.strokePath()
    }
}