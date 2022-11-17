//
//  NetworkMonitor.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 17.11.2022.
//

import Foundation
import Network

extension Notification.Name {
    static let connectivityStatus = Notification.Name(rawValue: Constants.connectivityStatus)
}

// MARK: - CaseIterable

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
        .other,
        .wifi,
        .cellular,
        .loopback,
        .wiredEthernet
    ]
}

final class NetworkMonitor {
    
    // MARK: - Properties

    static let shared = NetworkMonitor()

    private let queue = DispatchQueue(label: Constants.queueName)
    private let monitor: NWPathMonitor

    private(set) var isConnected = false
    private(set) var isExpensive = false
    private(set) var currentConnectionType: NWInterface.InterfaceType?
    
    // MARK: - Lifecycle

    private init() {
        monitor = NWPathMonitor()
    }

    // MARK: - Monitoring

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.isExpensive = path.isExpensive
            self?.currentConnectionType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first
            
            NotificationCenter.default.post(name: .connectivityStatus, object: nil)
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}

// MARK: - Constants

private extension NetworkMonitor {
    enum Constants {
        static let queueName: String = "NetworkConnectivityMonitor"
    }
}

private extension Notification.Name {
    enum Constants {
        static let connectivityStatus: String = "connectivityStatusChanged"
    }
}
