//
//  RetryInfoView.swift
//  CityWeather
//
//  Created by Michał Krupa on 04/02/2024.
//

import SwiftUI

struct RetryInfoView: View {
    var closure: ()->()
    
    init(_ closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    var body: some View {
        Text("somethingWrong")
        Text("retryTap")
            .onTapGesture {
                closure()
            }
    }
}
