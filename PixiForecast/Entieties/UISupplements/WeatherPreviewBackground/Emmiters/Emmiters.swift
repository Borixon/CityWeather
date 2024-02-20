//
//  Emmiters.swift
//  PixiForecast
//
//  Created by Michał Krupa on 17/02/2024.
//

import Foundation
import QuartzCore

protocol IEmmiter {
    var cells: [IEmmiterCell] { get }
    var shape: CAEmitterLayerEmitterShape { get }
    var position: CGPoint { get }
    var size: CGSize { get }
}

protocol IEmmiterCell {
    var birthRate: Float { get }
    var direction: Float { get }
    var lifetime: Float { get }
    var velocity: Float { get }
    var scale: Float { get }
    var scaleRange: Float { get }
    var emissionLongitude: Float { get } //Radians
    var emissionRange: Float { get }
}
