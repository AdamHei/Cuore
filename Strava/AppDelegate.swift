//
//  AppDelegate.swift
//  WahooTest
//
//  Created by Adam Heimendinger on 1/3/20.
//  Copyright © 2020 Adam Heimendinger. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let connector: WFHardwareConnector = .shared()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(connector.enableBTLE(true))
//        connector.delegate = self

        
//        let params = WFConnectionParams()
//        params.sensorType = WF_SENSORTYPE_HEARTRATE
//        params.networkType = WF_NETWORKTYPE_ANY
//        do {
//            try connector.requestSensorConnection(params, withProximity: WF_PROXIMITY_RANGE_10, error: ())
//        } catch {
//            print(error)
//        }
//        connection?.delegate = self
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: WFSensorConnectionDelegate {
    func connection(_ connectionInfo: WFSensorConnection!, stateChanged connState: WFSensorConnectionStatus_t) {
        print()
    }
    
    func connectionDidTimeout(_ connectionInfo: WFSensorConnection!) {
        print()
    }
    
    func connection(_ connectionInfo: WFSensorConnection!, rejectedByDeviceNamed deviceName: String!, appAlreadyConnected appName: String!) {
        print()
    }
}

extension AppDelegate: WFHardwareConnectorDelegate {
    
    func hardwareConnectorHasData() {
        print()
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!, receivedRawData data: Data!, forUUID uuid: NSNumber!, deviceUUIDString: String!) {
        print()
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!, stateChanged currentState: WFHardwareConnectorState_t) {
        print()
//        let params = WFConnectionParams()
//        params.sensorType = WF_SENSORTYPE_HEARTRATE
//        params.networkType = WF_NETWORKTYPE_ANY
//        do {
//            connection = try connector.requestSensorConnection(params, withProximity: WF_PROXIMITY_RANGE_10, error: ()) as? WFHeartrateConnection
//        } catch {
//            print(error)
//        }
//        connection?.delegate = self
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!, antBridgeStateChanged eState: WFAntBridgeState_t, onDevice deviceUUIDString: String!) {
        print()
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!, connectedSensor connectionInfo: WFSensorConnection!) {
        print()
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!, disconnectedSensor connectionInfo: WFSensorConnection!) {
        print()
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!, didCompleteCheckingAvailibleFirmwareFor connectionInfo: WFSensorConnection!, error: Error!) {
        print()
    }
    
    func hardwareConnector(_ hwConnector: WFHardwareConnector!, hasFirmwareUpdateAvailableFor connectionInfo: WFSensorConnection!, required: Bool, withWahooUtilityAppURL wahooUtilityAppURL: URL!) {
        print()
    }
}

