//
//  MainTabView.swift
//  Strava
//
//  Created by Adam Heimendinger on 1/4/20.
//  Copyright © 2020 Adam Heimendinger. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        ZStack {
            TabView {
                WorkoutView(workouts: Workout.randomList(length: 100))
                    .tabItem {
                        VStack {
                            Image(systemName: "waveform.path.ecg")
                            Text("Workouts")
                        }
                }
                Text("//TODO Competitions").tabItem {
                    VStack {
                        Image(systemName: "rectangle.stack.person.crop")
                        Text("Competitions")
                    }
                }
                Text("//TODO Social").tabItem {
                    VStack {
                        Image(systemName: "person.3.fill")
                        Text("Clubs")
                    }
                }
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
