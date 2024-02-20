//
//  OutdoorsView.swift
//  PixiForecast
//
//  Created by Michał Krupa on 19/02/2024.
//

import SwiftUI

struct OutdoorsView: UIViewControllerRepresentable {
    
    private let data: DBCity
    
    init(_ data: DBCity) {
        self.data = data
    }
    
    func makeUIViewController(context: Context) -> OutdoorsVC {
        OutdoorsVC(data)
    }
    
    func updateUIViewController(_ uiViewController: OutdoorsVC, context: Context) {
        
    }
    
    typealias UIViewControllerType = OutdoorsVC
    
    
}
