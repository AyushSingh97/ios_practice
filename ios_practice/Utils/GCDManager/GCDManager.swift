import Foundation

// Protocol to be implemented by both GCDManagerImpl and OperationQueueManager classes
protocol GCDManager {
    func run(_ block: @escaping () -> Void)
}

// Factory class that creates GCDManager instances
class GCDManagerFactory {
    
    enum NSOperationQoS {
        case userInteractive
        case userInitiated
        case utility
        case background
        case defaultQoS
        case unspecified
    }
    
    enum DispatchType {
        case gcd(label: String, qos: NSOperationQoS)
        case operationQueue(label: String, qos: NSOperationQoS)
    }
    
    static func create(_ dispatchType: DispatchType) -> GCDManager {
        switch dispatchType {
        case .gcd(let label, let qos):
            let dispatchQoS: DispatchQoS
            switch qos {
            case .userInteractive:
                dispatchQoS = .userInteractive
            case .userInitiated:
                dispatchQoS = .userInitiated
            case .utility:
                dispatchQoS = .utility
            case .background:
                dispatchQoS = .background
            case .defaultQoS:
                dispatchQoS = .default
            case .unspecified:
                dispatchQoS = .unspecified
            }
            return DispatchQueueManager(label: label, qos: dispatchQoS)
        case .operationQueue(let label, let qos):
            let operationQoS: QualityOfService
            switch qos {
            case .userInteractive:
                operationQoS = .userInteractive
            case .userInitiated:
                operationQoS = .userInitiated
            case .utility:
                operationQoS = .utility
            case .background:
                operationQoS = .background
            case .defaultQoS:
                operationQoS = .default
            case .unspecified:
                operationQoS = .default
            }
            return OperationQueueManager(label: label, qos: operationQoS)
        }
    }

}
