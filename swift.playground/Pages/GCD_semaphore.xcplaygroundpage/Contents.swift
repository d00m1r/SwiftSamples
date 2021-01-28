//: [Previous](@previous)

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
let queue = DispatchQueue(label: "myQueue", attributes: .concurrent)
let semaphore = DispatchSemaphore(value: 2)//

//queue.async {
//    semaphore.wait()
//    Thread.sleep(forTimeInterval: 1)//~sleep()
//    print("method 1")
//    semaphore.signal()
//}
//queue.async {
//    semaphore.wait()
//    sleep(1)
//    print("method 2")
//    semaphore.signal()
//}
//queue.async {
//    semaphore.wait()
//    sleep(1)
//    print("method 3")
//    semaphore.signal()
//}

DispatchQueue.concurrentPerform(iterations: 10) { (id) in
    semaphore.wait()
    print(id)
    sleep(1)
    semaphore.signal()
}
//: [Next](@next)
