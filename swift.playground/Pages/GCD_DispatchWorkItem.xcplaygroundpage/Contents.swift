//: [Previous](@previous)

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "myQueue1", attributes: .concurrent)
    
    func create() {
        let workItem = DispatchWorkItem {
            print("start task", Thread.current)
        }
        workItem.notify(queue: .main) {
            print("Task finish", Thread.current)
        }
        queue.async(execute: workItem)
    }
}
//let dispatchWorkItem1 = DispatchWorkItem1()
//dispatchWorkItem1.create()

class DispatchWorkItem2 {
    let queue = DispatchQueue(label: "myQueue2", attributes: .concurrent)
    
    fileprivate func create () {
        let workItem = DispatchWorkItem {
            print("execute Task 4", Thread.current)
        }
        workItem.notify(queue: queue) {
            if workItem.isCancelled{
                print("was cancelled")
            }else{
                print("4'th task done!")
            }
        }
        
        queue.async {
            //workItem.cancel()
            sleep(4)
            print("execute Task 1", Thread.current)
        }
        
        queue.async {
            sleep(7)
            print("execute Task 2", Thread.current)
        }
    
        queue.async {
            sleep(3)
            workItem.cancel()
            print("execute Task 3", Thread.current)
        }
        
        queue.async(execute: workItem)
        
        workItem.cancel()//Если таска начала выполняться, то её нельзя отменить/ отличие от OperationQueue
    }
}
let dispatchWorkItem2 = DispatchWorkItem2()
dispatchWorkItem2.create()
//: [Next](@next)
