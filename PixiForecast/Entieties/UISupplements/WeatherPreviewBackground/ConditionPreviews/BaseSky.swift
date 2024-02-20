//
//  BaseSky.swift
//  PixiForecast
//
//  Created by Michał Krupa on 20/02/2024.
//

import UIKit

class BaseSky: UIView, ISky {
    
    var sun: ISun
    var morningSky: Any?
    var noonSky: Any?
    var eavningSky: Any?
    var nightSky: Any?
    
    var sunStart: CGPoint
    var sunEnd: CGPoint
    var sunPos: CGPoint
    
    var sunrise: TimeInterval
    var sunset: TimeInterval
    
    /// TEMP
    var now: TimeInterval = Date.now.timeIntervalSince1970
    
    required init(
        sunrise: TimeInterval,
        sunset: TimeInterval,
        timeNow: TimeInterval,
        bounds: CGSize) {
        
            self.sunrise = sunrise
            self.sunset = sunset
            self.now = timeNow
            
            self.sunStart = ClearSky.sunPosition(
                bounds: bounds,
                sunriseTime: sunrise,
                sunsetTime: sunset,
                currentTime: sunrise,
                sunSize: sun.size)
            self.sunEnd = ClearSky.sunPosition(
                bounds: bounds,
                sunriseTime: sunrise,
                sunsetTime: sunset,
                currentTime: sunset,
                sunSize: sun.size)
            self.sunPos = ClearSky.sunPosition(
                bounds: bounds,
                sunriseTime: sunrise,
                sunsetTime: sunset,
                currentTime: timeNow,
                sunSize: sun.size)
            
            super.init(frame: .init(origin: .zero, size: bounds))
            
            backgroundColor = .blue
            addSubview(sun)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sunPosition(
        bounds: CGSize,
        sunriseTime: TimeInterval,
        sunsetTime: TimeInterval,
        currentTime: TimeInterval,
        sunSize: CGSize) -> CGPoint {
            
            let W = Float(bounds.width)
            let H = Float(bounds.height)
            
            let totalDaytime = sunsetTime - sunriseTime
            let elapsedTime = currentTime - sunriseTime
            let percentageOfDayPassed = Float(elapsedTime / totalDaytime)
            
            /// horizontal margin
            let mh: Float = Float(sunSize.width)
            /// vertical margin
            let mv: Float = 100.0
            let h: Float = W/2.0
            let x: Float = percentageOfDayPassed * (W - 2 * mh) + mh
            let a: Float = H / pow(mh - h, 2)
            let y: Float = a * pow((x-h), 2) + mv
            
            return CGPoint(
                x: Double(x) - sunSize.width/2.0,
                y: Double(y) - sunSize.height/2.0)
        }
    
    
    func scheduleSun() {
        Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: { _ in
                
                self.now += 1200
                self.sunPos = ClearSky
                    .sunPosition(
                        bounds: self.bounds.size,
                        sunriseTime: self.sunrise,
                        sunsetTime: self.sunset,
                        currentTime: self.now,
                        sunSize: self.sun.size)
                
                if self.now > self.sunset {
                    self.now = self.sunrise
                }
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
                    self.sun.frame.origin = self.sunPos
                })
                
            })
    }
    
    
}
