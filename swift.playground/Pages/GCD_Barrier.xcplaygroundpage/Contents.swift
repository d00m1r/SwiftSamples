//: [Previous](@previous)

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true //асинхронные запросы продолжают работать, даже когда main поток заканчивает свою работу

//Barrier защита критических секций
var arr: [Int] = []
DispatchQueue.concurrentPerform(iterations: 10) { (index) in//race condition
    arr.append(index)
}
print(arr)

class SafeArr<T> {
    private var arr:[T] = []
    private let queue = DispatchQueue(label: "myQueue", attributes: .concurrent)
    
    func append(_ value: T){//защита записи
        queue.async (flags: .barrier) {
            self.arr.append(value)
        }
    }
    var arrValues: [T]{//защита чтения
        var result = [T]()
        queue.async{
            result = self.arr
        }
        return result
    }
}

var arrSafe = SafeArr<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    arrSafe.append(index)
}
print("safe", arrSafe.arrValues)


//Simple
let queue = DispatchQueue.global()
queue.async {
    //task1
}
queue.async {
    //task2
}//порядок выполнения таск1 и таск2 неизвестен, однако точно знаем, что третья задача, начнется не раньше, чем они закончатся
queue.async(flags: DispatchWorkItemFlags.barrier) {
    //task3
}
//: [Next](@next)
