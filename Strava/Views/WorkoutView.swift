//
//  WorkoutView.swift
//  WahooTest
//
//  Created by Adam Heimendinger on 1/3/20.
//  Copyright © 2020 Adam Heimendinger. All rights reserved.
//

import SwiftUI

struct WorkoutView: View {
    
    @State var presentingStartWorkout = false
    
    let workouts: [Workout]
    
    let heartRateViewModel = HeartRateViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HeartRateView().environmentObject(heartRateViewModel)
                List(workouts.sorted(by: {
                    $0.startTime > $1.startTime
                }), id: \.id) { workout in
                    NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                        WorkoutRow(workout: workout)
                    }
                }
            }
//            .navigationBarTitle(Text("Workouts"))
            .navigationBarItems(trailing: Button(action: {
                self.presentingStartWorkout.toggle()
            }, label: {
                Image(systemName: "plus.circle").font(.title)
            }))
        }.sheet(isPresented: $presentingStartWorkout) {
            StartWorkoutView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workouts: Workout.randomList(length: 10))
    }
}
