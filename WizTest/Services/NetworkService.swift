//
//  NetworkService.swift
//  WizTest
//
//  Created by Yael Bilu Eran on 14/12/2020.
//

import Alamofire

class NetworkService {
    
    //shared instance
    static let shared = NetworkService()
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    func startNetworkReachabilityObserver() {
        
        self.reachabilityManager?.startListening { status in
            switch status {
                
            case .notReachable:
                print("The network is not reachable")
                
            case .unknown :
                print("It is unknown whether the network is reachable")
                
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                
            case .reachable(.cellular):
                print("The network is reachable over the cellular connection")
            }
        }
    }
        
    
    func isNetworkReachable()->Bool{
         return Alamofire.NetworkReachabilityManager(host: "www.apple.com")?.isReachable ?? true
    }
}
