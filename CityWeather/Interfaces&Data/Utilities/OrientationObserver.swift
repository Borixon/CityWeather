//
//  OrientationObserver.swift
//  CityWeather
//
//  Created by Michał Krupa on 11/02/2024.
//

import Foundation
import UIKit
import RxRelay

class OrientationObserver: ObservableObject {
    
    private lazy var _publisher: BehaviorRelay<UIDeviceOrientation> = {
        .init(value: current)
    }()
    
    var publisher: BehaviorRelay<UIDeviceOrientation> {
        _publisher
    }
    
    var current: UIDeviceOrientation {
        UIDevice.current.orientation
    }
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationDidChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func orientationDidChange() {
        publisher.accept(current)
    }
}
