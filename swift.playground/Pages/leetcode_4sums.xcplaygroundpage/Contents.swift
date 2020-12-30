//: [Previous](@previous)

import Foundation

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int:Int]()
        for (index,value) in nums.enumerated(){
            if let lastIndex = dict[target-value]{
                return[lastIndex,index]
            }
            dict[value] = index
            print(dict)
        }
        return []
    }
    func fourSum(_ nums: [Int], _ target: Int) -> [Int] {
        
    }
}
var nums = [1,0,-1,0,-2,2]
var target = 0
var some = Solution() //[[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
print("result:",some.twoSum(nums, target))

//: [Next](@next)
