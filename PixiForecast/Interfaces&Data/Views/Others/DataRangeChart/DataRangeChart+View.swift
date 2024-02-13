//
//  TimeRangeChart.swift
//  CityWeather
//
//  Created by Michał Krupa on 06/02/2024.
//

import SwiftUI
import Charts
 
extension DataRangeChart: View {
    
    var body: some View {
        VStack(alignment:.center) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                    .font(Font.system(
                        size: 16,
                        weight: .medium))
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            Chart {
                ForEach(Array(data.enumerated()), id:\.offset) { i, entry in
                    // TODO: Check for float values
                    BarMark(
                        x: .value("i", i),
                        yStart: .value("", entry.min),
                        yEnd: .value("", entry.max),
                        width: Marks.dimension)
                    .foregroundStyle(.white)
                    .annotation(
                        position: .bottom,
                        alignment: .center) {
                            Text(data[i].annotation)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .font(Font.system(
                                    size: 12,
                                    weight: .light))
                        }
                    PointMark(
                        x: .value("\(i)", i),
                        y: .value("e", entry.max))
                    .foregroundStyle(.white)
                }
                
            }
            .chartYScale(domain: [from-Int(margin), to+Int(margin)])
            .chartYAxis { AxisMarks(values: yAxisValues) }
            .chartXAxis(.hidden)
            .padding(.horizontal, 8)
            .padding(.bottom, 24)
        }
        .background(Background.box)
    }
}

#Preview {
    DataRangeChart(
        title: "My data",
        data: [
            MinMax(min: 8, max: 10, annotation: "22:11"),
            MinMax(min: 11, max: 12, annotation: "b"),
            MinMax(min: 11, max: 12, annotation: "c"),
            MinMax(min: 11, max: 12, annotation: "d"),
            MinMax(min: 11, max: 11, annotation: "e"),
            MinMax(min: 11, max: 11, annotation: "f")
        ]
    )
}
