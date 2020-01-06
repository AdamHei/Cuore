//
//  HeartRateView.swift
//  Strava
//
//  Created by Adam Heimendinger on 1/5/20.
//  Copyright © 2020 Adam Heimendinger. All rights reserved.
//

import SwiftUI

struct HeartRateView: View {
    
    @EnvironmentObject var heartRateViewModel: HeartRateViewModel
    
    var body: some View {
        VStack {
            Text("Heart rate: \(heartRateViewModel.heartRateString)").font(.largeTitle)
            HStack {
                Text("Sensor connection:").font(.title)
                heartRateViewModel.sensorConnectionStatus.imageForStatus.font(.title)
            }
        }
    }
    
}

extension WFSensorConnectionStatus_t {
    var imageForStatus: some View {
        switch self {
        case WF_SENSOR_CONNECTION_STATUS_IDLE:
            return Image(systemName: "heart.circle.fill").foregroundColor(.red)
        case WF_SENSOR_CONNECTION_STATUS_CONNECTING:
            return Image(systemName: "heart.circle.fill").foregroundColor(.orange)
        case WF_SENSOR_CONNECTION_STATUS_CONNECTED:
            return Image(systemName: "heart.circle.fill").foregroundColor(.green)
        case WF_SENSOR_CONNECTION_STATUS_INTERRUPTED:
            return Image(systemName: "heart.circle.fill").foregroundColor(.black)
        case WF_SENSOR_CONNECTION_STATUS_DISCONNECTING:
            return Image(systemName: "heart.circle.fill").foregroundColor(.yellow)
        default:
            fatalError()
        }
    }
}

struct HeartRateView_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateView().environmentObject(HeartRateViewModel.example)
    }
}
