//
//  PreviewBackground.swift
//  PixiForecast
//
//  Created by Michał Krupa on 17/02/2024.
//

import UIKit
import Foundation
import QuartzCore

protocol IPreviewBackground: UIView {
    
    init(time: TimeInterval, size: CGSize, data: DBCity)
    
    var emmiters: [IEmmiter] { get set }
    var sky: ISky { get set }
    
    func setupDay(_ data: DBCity)
    
}

class ClearSkyBackground: UIView, IPreviewBackground {
    
    var emmiters: [IEmmiter] = []
    var sky: ISky
    
    required init(
        time: TimeInterval,
        size: CGSize,
        data: DBCity) {
        
            self.sky = ClearSky(
            sunrise: data.sunrise,
            sunset: data.sunset,
            timeNow: time,
            bounds: size)
            
        super.init(frame: .init(
            origin: .zero,
            size: size))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDay(_ data: DBCity) {
        
    }
    
}
