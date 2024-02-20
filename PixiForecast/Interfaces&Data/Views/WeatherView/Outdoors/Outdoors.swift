//
//  Outdoors.swift
//  PixiForecast
//
//  Created by Michał Krupa on 19/02/2024.
//

import UIKit
import SwiftUI

final class OutdoorsVC: UIViewController {
    
    private var data: DBCity
    private var sky: ClearSky!
    private var ground: UIView!
    
    init(_ data: DBCity) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the emitter layer
        /*let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = view.bounds
        view.layer.addSublayer(emitterLayer)
        
        // Configure the emitter layer
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width, y: 0)
        emitterLayer.emitterSize = CGSize(width: view.bounds.width/3.0, height: 0)
        emitterLayer.emitterShape = .line
        
        // Create a particle cell
        let particleCell = CAEmitterCell()
        particleCell.contents = UIImage(named: "raindrop")?.cgImage // Set the image for the particle
        particleCell.birthRate = 20 // Number of particles emitted per second
        particleCell.lifetime = 6 // Lifetime of each particle
        particleCell.velocity = 200 // Initial velocity of each particle
        particleCell.scale = 0.1 // Initial scale of each particle
        particleCell.scaleRange = 0.2 // Range of scale variation
        particleCell.emissionLongitude = CGFloat.pi // Direction of particle emission (downward)
        particleCell.emissionRange = 0.1
        
        // Add the particle cell to the emitter layer
        emitterLayer.emitterCells = [particleCell]
        
        let a = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        a.fromValue = CGPoint(x: 0, y: 0)
        a.toValue = CGPoint(x: view.bounds.width, y: 0)
        a.duration = 8
        a.repeatCount = 100
        a.autoreverses = true
        
        emitterLayer.add(a, forKey: #keyPath(CALayer.position))*/
        
        sky = ClearSky(
            sunrise: data.sunrise,
            sunset: data.sunset,
            timeNow: Date.now.timeIntervalSince1970,
            bounds: view.frame.size)
        
        view.addSubview(sky)
        sky.snp.makeConstraints {
            $0.top.centerX.width.equalToSuperview()
            $0.height.equalTo(sky.snp.width)
        }
        
        ground = .init(frame: .zero)
        view.addSubview(ground)
        ground.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalTo(sky.snp.bottom)
        }
        
        ground.backgroundColor = .green
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sky.scheduleSun()
    }
}
