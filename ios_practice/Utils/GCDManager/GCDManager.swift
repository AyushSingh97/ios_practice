import Foundation
// Protocol to be implemented by both DispatchQueueManager and OperationQueueManager classes
protocol GCDManager {
    func run(_ block: @escaping () -> Void)
}

// Factory class that creates GCDManager instances

/**
 Example:
```
GCDManagerFactory.create(.operationQueue(label: "com.example.myqueue", qos: .background))
```
*/

class GCDManagerFactory {
    
    // Enum to represent Quality of Service levels for NSOperationQueue
    enum QualityOfServices {
        case userInteractive
        case userInitiated
        case utility
        case background
        case defaultQoS
        case unspecified
    }
    
    // Enum to represent the dispatch type to create either GCD or OperationQueue manager instance
    enum DispatchType {
        case gcd(label: String, qos: QualityOfServices)
        case operationQueue(label: String, qos: QualityOfServices)
    }
    
    // Factory method to create a GCDManager instance based on the provided dispatch type
    static func create(_ dispatchType: DispatchType) -> GCDManager {
        switch dispatchType {
        case .gcd(let label, let qos):
            // Convert the provided NSOperationQoS to DispatchQoS for GCD implementation
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
            // Convert the provided NSOperationQoS to QualityOfService for NSOperationQueue implementation
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
