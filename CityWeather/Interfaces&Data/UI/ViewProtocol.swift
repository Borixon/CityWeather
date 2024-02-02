//
//  ViewProtocol.swift
//  CityWeather
//
//  Created by Michał Krupa on 01/02/2024.
//

import Foundation
import SwiftUI

protocol ViewProtocol {
    
    associatedtype CV: ContentViewProtocol where CV.VM == VM
    associatedtype VM: ViewModelProtocol
    
    var contentView: CV! { get }
    var viewModel: VM { get }
    
}

extension ViewProtocol {
    
    @ViewBuilder func buildContentView<C:ContentViewProtocol>(
        _ contentView: C) -> some View {
            if UIDevice.current.userInterfaceIdiom == .phone {
                contentView.iPhoneView
            } else {
                contentView.iPadView
            }
    }
    
    @ViewBuilder var contentBody: some View {
        buildContentView(contentView)
            .onAppear(perform: {
                viewModel.onStart()
            })
    }
}
