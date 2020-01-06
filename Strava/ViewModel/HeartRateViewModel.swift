//
//  File.swift
//  Strava
//
//  Created by Adam Heimendinger on 1/5/20.
//  Copyright © 2020 Adam Heimendinger. All rights reserved.
//

import SwiftUI
import Combine

final class HeartRateViewModel: NSObject, ObservableObject {
    
    static let example: HeartRateViewModel = {
        let model = HeartRateViewModel()
        model.heartRateString = "101 BPM"
        model.sensorConnectionStatus = WF_SENSOR_CONNECTION_STATUS_CONNECTED
        return model
    }()
    
    @Published var heartRateString: String = "N/A"
    @Published var sensorConnectionStatus: WFSensorConnectionStatus_t = WF_SENSOR_CONNECTION_STATUS_IDLE
    
    let connector: WFHardwareConnector = .shared()!
    var connection: WFHeartrateConnection?
    var timer: Timer?
    
    override init() {
        super.init()
        connector.delegate = self
        requestConnection()
    }
    
    deinit {
        connection?.disconnect()
        connector.delegate = nil
    }
    
    func requestConnection() {
        let currentState = connector.currentState()
        switch currentState {
        case WF_HWCONN_STATE_BT40_ENABLED:
            let params = WFConnectionParams()
            params.sensorType = WF_SENSORTYPE_HEARTRATE
            params.networkType = WF_NETWORKTYPE_ANY
            do {
                connection = try connector.requestSensorConnection(params,
                                                                   withProximity: WF_PROXIMITY_RANGE_10,
                                                                   error: ()) as? WFHeartrateConnection
            } catch {
                print(error)
            }
            connection?.delegate = self
        default:
            print("unhandled state: \(currentState)")
        }
    }
    
}

extension HeartRateViewModel: WFSensorConnectionDelegate {
    
    func connection(_ connectionInfo: WFSensorConnection!,
                    stateChanged connState: WFSensorConnectionStatus_t) {
        print(connState.stringValue)
        sensorConnectionStatus = connState
    }
    
    func connectionDidTimeout(_ connectionInfo: WFSensorConnection!) {
        print("Sensor connection timeout")
    }
    
    func connection(_ connectionInfo: WFSensorConnection!,
                    rejectedByDeviceNamed deviceName: String!,
                    appAlreadyConnected appName: String!) {
        print("Sensor connection rejected by: \(String(describing: deviceName))")
    }
    
}

extension WFSensorConnectionStatus_t {
    
    var stringValue: String {
        switch self {
        case WF_SENSOR_CONNECTION_STATUS_IDLE:
            return "Sensor connection idle"
        case WF_SENSOR_CONNECTION_STATUS_CONNECTING:
            return "Sensor connecting"
        case WF_SENSOR_CONNECTION_STATUS_CONNECTED:
            return "Sensor connected"
        case WF_SENSOR_CONNECTION_STATUS_INTERRUPTED:
            return "Sensor connection interrupted"
        case WF_SENSOR_CONNECTION_STATUS_DISCONNECTING:
            return "Sensor connection disconnecting"
        default:
            fatalError()
        }
    }
}

extension HeartRateViewModel: WFHardwareConnectorDelegate {
    
    func hardwareConnectorHasData() {
        print("We've got data!")
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!,
                           receivedRawData data: Data!,
                           forUUID uuid: NSNumber!, deviceUUIDString: String!) {
        print("data: \(String(describing: data))")
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!,
                           stateChanged currentState: WFHardwareConnectorState_t) {
        switch currentState {
        case WF_HWCONN_STATE_BT40_ENABLED:
            let params = WFConnectionParams()
            params.sensorType = WF_SENSORTYPE_HEARTRATE
            do {
                connection = try connector.requestSensorConnection(params,
                                                                   withProximity: WF_PROXIMITY_RANGE_10,
                                                                   error: ()) as? WFHeartrateConnection
            } catch {
                print(error)
            }
            connection?.delegate = self
        default:
            print("unhandled state: \(currentState)")
        }
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!,
                           antBridgeStateChanged eState: WFAntBridgeState_t,
                           onDevice deviceUUIDString: String!) {
        print()
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!,
                           connectedSensor connectionInfo: WFSensorConnection!) {
        print("Connected: \(String(describing: connectionInfo.deviceUUIDString))")
        timer = Timer.scheduledTimer(withTimeInterval: 3,
                                     repeats: true,
                                     block: { [weak self] (_) in
            guard let heartRate = self?.connection?.getHeartrateData() else {
                print("no heart rate data")
                return
            }
            self?.heartRateString = heartRate.formattedHeartrate(true)
        })
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!,
                           disconnectedSensor connectionInfo: WFSensorConnection!) {
        print("Disconnected: \(String(describing: connectionInfo.deviceUUIDString))")
        timer?.invalidate()
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!,
                           didCompleteCheckingAvailibleFirmwareFor connectionInfo: WFSensorConnection!,
                           error: Error!) {
        print()
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!,
                           hasFirmwareUpdateAvailableFor connectionInfo: WFSensorConnection!,
                           required: Bool,
                           withWahooUtilityAppURL wahooUtilityAppURL: URL!) {
        print()
    }
    
}
