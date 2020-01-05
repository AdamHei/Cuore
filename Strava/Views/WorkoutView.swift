//
//  WorkoutView.swift
//  WahooTest
//
//  Created by Adam Heimendinger on 1/3/20.
//  Copyright © 2020 Adam Heimendinger. All rights reserved.
//

import SwiftUI

struct WorkoutView: View {
    let workouts: [Workout]
    
    var body: some View {
        NavigationView {
            List(workouts, id: \.id) {
                WorkoutRow(workout: $0)
            }
            .navigationBarTitle(Text("Workouts"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workouts: Workout.randomList(length: 10))
    }
}
