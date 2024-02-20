//
//  Sky.swift
//  PixiForecast
//
//  Created by Michał Krupa on 17/02/2024.
//

import UIKit

protocol ISky: UIView {
    
    init(sunrise: TimeInterval,
         sunset: TimeInterval,
         timeNow: TimeInterval,
         bounds: CGSize)
    
    var sun: ISun { get set }
    
    /// Backgrounds for given
    var morningSky: Any? { get }
    var noonSky: Any? { get }
    var eavningSky: Any? { get }
    var nightSky: Any? { get }
    
    /// Position of sun in dawn
    var sunStart: CGPoint { get }
    /// Position of sun in dusk
    var sunEnd: CGPoint { get }
    /// Current sun  position
    var sunPos: CGPoint { get set }
    
    var sunrise: TimeInterval { get set }
    var sunset: TimeInterval { get set }
    
    func sunPosition(
        bounds: CGSize,
        sunriseTime: TimeInterval,
        sunsetTime: TimeInterval,
        currentTime: TimeInterval,
        sunSize: CGSize) -> CGPoint
}
