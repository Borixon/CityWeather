//
//  ViewModelProtocol.swift
//  CityWeather
//
//  Created by Michał Krupa on 01/02/2024.
//

import RxSwift
import SwiftUI

protocol ViewModelProtocol: ObservableObject {
    var bag: DisposeBag { get }
    func onStart()
}
