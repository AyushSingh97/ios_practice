import Foundation
// Concrete implementation of the GCDManager protocol using NSOperationQueue
class OperationQueueManager: GCDManager {
    
    private let queue: OperationQueue
    
    init(label: String, qos: QualityOfService) {
        queue = OperationQueue()
        queue.name = label
        queue.qualityOfService = qos
    }
    
    func run(_ block: @escaping () -> Void) {
        queue.addOperation(BlockOperation(block: block))
    }
}
