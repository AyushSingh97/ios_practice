import Foundation

// Concrete implementation of the GCDManager protocol using GCD
class DispatchQueueManager: GCDManager {
    
    private let queue: DispatchQueue
    
    init(label: String, qos: DispatchQoS) {
        queue = DispatchQueue(label: label, qos: qos)
    }
    
    func run(_ block: @escaping () -> Void) {
        queue.async(execute: block)
    }
}

