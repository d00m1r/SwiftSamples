//: [Previous](@previous)

import Foundation

var nums = Array<Int>(1...10)
nums = nums.map{$0+1}
nums = nums.map { (el:Int) -> Int in
    el + 1
}

var arr1 = [[1,2],[3,4]]
var res1 = arr1.flatMap{$0}
print("res1", res1)

var arr2 = [1,nil,3,nil,5]
var res2 = arr2.compactMap {$0}
print("res2", res2)

var arr3 = [1,2,15]
var res3 = arr3.reduce(into: 0){res, item in
    res += item
}
print("res3", res3)

var dic = arr3.reduce(into: [Int:String]()) { res, item in
    res[item] = "\(item)"
}

var res4 = arr3.filter {$0 > 5}
var index = arr3.firstIndex(of: 1)
var element = arr3.first {$0 > 5}

arr3.forEach {print($0)}
//: [Next](@next)
