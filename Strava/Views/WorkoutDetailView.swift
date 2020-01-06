//
//  WorkoutDetailView.swift
//  Strava
//
//  Created by Adam Heimendinger on 1/4/20.
//  Copyright © 2020 Adam Heimendinger. All rights reserved.
//

import SwiftUI
import Chart

struct WorkoutDetailView: View {
    let workout: Workout
    
    var scaledWorkoutReadings: [Double] {
        return workout.readings.map({ Double($0) }).map({
            $0 / Double(workout.readings.max()!)
        })
    }
    
    var body: some View {
        VStack {
            Text("Workout timeline")
            Chart(data: self.scaledWorkoutReadings).chartStyle(LineChartStyle(.quadCurve,
                                                                              lineColor: .blue,
                                                                              lineWidth: 1))
                .frame(width: 400, height: 150, alignment: .center)
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: Workout.generateRandom())
    }
}
