import Foundation

/**
 A `Debouncer` delays the execution of a function by a specified time interval. If the function is called again before the time interval has elapsed, the delay is reset and the function is executed again after the time interval has elapsed since the last call.
 */
class Debouncer {
    private let delay: TimeInterval
    private var timer: Timer?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    /**
     Debounces the given action.
     
     - parameter action: The action to be executed after the specified delay.
     */
    func debounce(action: @escaping () -> Void) {
        
        if(timer == nil){
            action()
            timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { _ in
                self.timer = nil
            })
        }
        else{
        }
    }
}

/**
 A `DebouncerManager` manages a `Debouncer` and provides a way to set a callback that is debounced.
 */
/**
```
// Instantiate DebouncerManager with a delay of 0.5 seconds
let debouncerManager = DebouncerManager(delay: 0.5)

// Set the callback for the debouncer manager
debouncerManager.setCallback {
    print("Function call debounced!")
}

// Call the debouncer manager's `call()` method multiple times in quick succession
for _ in 1...10 {
    debouncerManager.call()
}

// Output:
// (Nothing is printed immediately)
// After 0.5 seconds:
// Function call debounced!

```
*/

class DebouncerManager {
    private let debouncer: Debouncer
    private var callback: (() -> Void)?
    
    /**
     Initializes a new `DebouncerManager` with the specified delay.
     
     - parameter delay: The delay to be used by the `Debouncer`.
     */
    init(delay: TimeInterval) {
        debouncer = Debouncer(delay: delay)
    }
    
    /**
     Sets the callback to be debounced.
     
     - parameter callback: The callback to be executed after the specified delay.
     */
    func setCallback(_ callback: (() -> Void)?) {
        self.callback = callback
    }
    
    /**
     Calls the debounced callback.
     */
    func call() {
        debouncer.debounce {
            self.callback?()
        }
    }
}
