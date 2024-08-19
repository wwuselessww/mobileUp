//
//  NetworkMonitor.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 19.08.24.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var conncetionType: ConnectionType = .connected
    private init() {
        monitor = NWPathMonitor()
        
    }
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self]path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) || path.usesInterfaceType(.cellular)  {
            conncetionType = .connected
            print("network connected")
        } else {
            conncetionType = .disconnected
            print("network disconnected")
        }
    }
    
    enum ConnectionType {
        case connected
        case disconnected

    }
    
}
