//
//  OrientationObserver.swift
//  CityWeather
//
//  Created by Michał Krupa on 11/02/2024.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

enum AppOrientation {
    case landscape
    case portrait
    
    init?(_ deviceOrientation: UIDeviceOrientation) {
        if [.landscapeLeft, .landscapeRight].contains(deviceOrientation) {
            self = .landscape
        } else if [.portrait, .portraitUpsideDown].contains(deviceOrientation) {
            self = .portrait
        } else {
            return nil
        }
    }
}

protocol OrientationObserverProtocol: AnyObject {
    var bag: DisposeBag { get }
    func orientationDidChange(to orientation: AppOrientation?)
}

final class OrientationObserver: ObservableObject {
    
    static let shared = OrientationObserver()
    
    private lazy var relay: BehaviorRelay<AppOrientation?> = {
        .init(value: .init(current))
    }()
    
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
    
    func subscribeToOrientationUpdates(_ observer: OrientationObserverProtocol) {
        relay.subscribe(onNext: { [weak observer] orientation in
            observer?.orientationDidChange(to: orientation)
        })
        .disposed(by: observer.bag)
    }
    
    @objc private func orientationDidChange() {
        guard ![.faceUp, .faceDown].contains(current) else {
            return
        }
        relay.accept(AppOrientation(current))
    }
}
