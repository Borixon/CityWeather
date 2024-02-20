//
//  Sun.swift
//  PixiForecast
//
//  Created by Michał Krupa on 17/02/2024.
//

import Foundation
import UIKit

protocol ISun: UIView {
    var image: UIImage? { get set }
    var size: CGSize { get }
}

class Sun: UIView, ISun {
    
    let size: CGSize = .init(width: 80, height: 80)
    var image: UIImage? = UIImage(named: "sun")
    
    init() {
        super.init(frame: .init(
            origin: .zero,
            size: size))
        
        let img = UIImageView(image: image!)
        img.frame = .init(
            origin: .zero,
            size: size)
        
        addSubview(img)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
