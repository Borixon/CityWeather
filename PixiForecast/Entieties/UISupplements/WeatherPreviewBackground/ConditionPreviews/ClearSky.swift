//
//  ClearSky.swift
//  PixiForecast
//
//  Created by Michał Krupa on 20/02/2024.
//

import UIKit

class ClearSky: BaseSky {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(
        sunrise: TimeInterval,
        sunset: TimeInterval,
        timeNow: TimeInterval,
        bounds: CGSize) {
            
        super.init(
            sunrise: sunrise,
            sunset: sunset,
            timeNow: timeNow,
            bounds: bounds)
    }
}
