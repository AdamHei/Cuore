//
//  WorkoutRow.swift
//  Strava
//
//  Created by Adam Heimendinger on 1/4/20.
//  Copyright © 2020 Adam Heimendinger. All rights reserved.
//

import SwiftUI

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(workout.formattedStartTime)").font(.headline)
            HStack {
                Text("Duration: \(workout.formattedDuration)").font(.subheadline)
                Spacer()
                Text("Avg: \(workout.averageHeartRate)bpm").font(.subheadline)
            }
            HStack {
                Text("Min: \(workout.minHeartRate)bpm").font(.subheadline)
                Spacer()
                Text("Max: \(workout.maxHeartRate)bpm").font(.subheadline)
            }
        }
    }
}

struct WorkoutRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutRow(workout: Workout.generateRandom()).previewLayout(.fixed(width: 300, height: 60))
            WorkoutRow(workout: Workout.generateRandom()).previewLayout(.fixed(width: 300, height: 60))
        }
    }
}
