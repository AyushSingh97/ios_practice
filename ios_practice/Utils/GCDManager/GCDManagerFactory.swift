import Foundation

enum GCDQoS {
    case userInteractive
    case userInitiated
    case utility
    case background
    case defaultQoS
    case unspecified
}

class GCDManagerFactory {
    
    /// Runs a block of code asynchronously on the specified queue.
    ///
    /// - Parameters:
    ///   - block: The block of code to run on the queue.
    ///   - label: The label for the queue.
    ///   - qos: The GCDQoS value for the queue.
    
    /**
     ```
    GCDManagerFactory.run({
        print("Async work item")
    }, label: "com.example.myqueue", qos: .userInteractive)
     ```
     */
    static func run(_ block: @escaping () -> Void, label: String, qos: GCDQoS) {
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
        
        let gcdManager = DispatchQueue(label: label, qos: dispatchQoS)
        gcdManager.async {
            block()
        }
    }
}
