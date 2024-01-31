//
//  ContentView.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import SwiftUI
import RxSwift

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear(perform: {
            
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
