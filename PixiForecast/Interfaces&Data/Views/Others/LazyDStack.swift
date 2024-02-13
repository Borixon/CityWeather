//
//  LazyDStack.swift
//  CityWeather
//
//  Created by Michał Krupa on 13/02/2024.
//

import SwiftUI

struct LazyDStack<C:View>: View {
    
    var horizontalAlignment = HorizontalAlignment.center
    var verticalAlignment = VerticalAlignment.center
    var spacing: CGFloat?
    var pinnedViews: PinnedScrollableViews = .init()
    @ViewBuilder var content: () -> C
    
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    var body: some View {
        switch sizeClass {
        case .regular:
            hStack
        case .compact, .none:
            vStack
        @unknown default:
            vStack
        }
    }
    
    var hStack: some View {
        LazyHStack(
            alignment: verticalAlignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: content)
    }
    
    var vStack: some View {
        LazyVStack(
            alignment: horizontalAlignment,
            spacing: spacing,
            pinnedViews: pinnedViews,
            content: content)
    }
}
