//: [Previous](@previous)

import Foundation

//NSLock
var counter = 0
var mutex = NSLock()
let thread1 = Thread {
    for _ in 0..<10{
        mutex.lock()
        counter += 1
        mutex.unlock()
    }
}
let thread2 = Thread{
    for _ in 0..<10{
        mutex.lock()
        counter += 1
        mutex.unlock()
    }
}
//thread1.start()
//thread2.start()

//NSRecursiveLock
let recursiveLock = NSRecursiveLock()
class RecursiveThread: Thread {
    override func main(){
        recursiveLock.lock()
        defer{
            recursiveLock.unlock()
        }
        print("1")
        callMe()
        print("3")
    }
    func callMe(){
        recursiveLock.lock()//с NSLock произошел бы deadlock
        defer{
            recursiveLock.unlock()
        }
        print("2")
    }
}
let thread = RecursiveThread()
//thread.start()

//NSCondition
var available = false
let condition = NSCondition()

class WriterThread: Thread {
    override func main(){
        condition.lock()
        print("start writing")
        available = true
        condition.signal()
        condition.unlock()
        print("end writing")
    }
}
class ReaderThread: Thread {
    override func main() {
        condition.lock()
        print("start reading")
        while(!available){//предикат необходим, в случае если сигнал был подан до того, как поток начал его ждать
            condition.wait()
        }
        available = false
        condition.unlock()
        print("end reading")
    }
}
let reader = ReaderThread()
let writer = WriterThread()
reader.start()
writer.start()
//: [Next](@next)
