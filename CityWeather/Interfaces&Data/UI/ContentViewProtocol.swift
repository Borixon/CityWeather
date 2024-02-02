//
//  ContentViewProtocol.swift
//  CityWeather
//
//  Created by Michał Krupa on 01/02/2024.
//

import SwiftUI

protocol ContentViewProtocol {
    
    associatedtype IPadView: View
    associatedtype IPhoneView: View
    associatedtype VM: ViewModelProtocol
    
    var iPadView: IPadView { get }
    var iPhoneView: IPhoneView { get }
    
}
