//
//  Workout.swift
//  Strava
//
//  Created by Adam Heimendinger on 1/4/20.
//  Copyright © 2020 Adam Heimendinger. All rights reserved.
//

import Foundation

struct Workout: Codable {
    let id: Int
    let startTime: Date
    let duration: Int // seconds
    let averageHeartRate: Int // bpm
    let maxHeartRate: Int // bpm
    let minHeartRate: Int // bpm
    
    let readings: [Int]
    let readingInterval: Int
    
    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: startTime)
    }
    
    var formattedDuration: String {
        var formattedDuration = ""
        var remainingDuration = duration
        let hours = remainingDuration / (60 * 60)
        if hours > 0 {
            formattedDuration += "\(hours)hr"
        }
        remainingDuration %= (60 * 60)
        let minutes = remainingDuration / 60
        if minutes > 0 {
            formattedDuration += "\(minutes)m"
        }
        remainingDuration %= 60
        if remainingDuration > 0 {
            formattedDuration += "\(remainingDuration)s"
        }
        return formattedDuration
    }
    
    static func randomList(length: Int) -> [Workout] {
        var list = [Workout]()
        for _ in 0...length {
            list.append(generateRandom())
        }
        return list
    }
    
    static func generateRandom() -> Workout {
        let min = Int.random(in: 60...115)
        let max = Int.random(in: 155...210)
        let avg = Int.random(in: min...max)
        let duration = Int.random(in: 1...90) * 60
        var readings = [Int]()
        for _ in 0..<duration / 60 {
            readings.append(Int.random(in: min...max))
        }
        let startTimeSinceNow = -1 * 60 * 60 * Int.random(in: 0...24) * Int.random(in: 1...90)
        return Workout(id: Int.random(in: 0...10000),
                       startTime: Date(timeIntervalSinceNow: Double(startTimeSinceNow)),
                       duration: duration,
                       averageHeartRate: avg,
                       maxHeartRate: max,
                       minHeartRate: min,
                       readings: readings,
                       readingInterval: 1)
    }
    
    static let sampleWorkouts: [Workout] = [
        Workout(id: Int.random(in: 0...10000),
                startTime: Date(timeIntervalSinceNow: -1 * 60 * 60 * 24),
                duration: 30 * 60,
                averageHeartRate: 164,
                maxHeartRate: 189,
                minHeartRate: 100,
                readings: [100, 105, 125, 139, 160, 170, 180, 189, 185, 180, 174, 169, 165, 169, 169],
                readingInterval: 10),
        Workout(id: Int.random(in: 0...10000),
                startTime: Date(timeIntervalSinceNow: -5 * 60 * 60 * 24),
                duration: 15 * 60,
                averageHeartRate: 140,
                maxHeartRate: 169,
                minHeartRate: 80,
                readings: [80, ],
                readingInterval: 10)
    ]
}
