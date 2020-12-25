//: [Previous](@previous)

import Foundation

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var max = nums.count-1
        var min = 0
        while min <= max{//если сделать просто <, то в случае с одним элементом, он его проигнорит
            var middle = (min+max)/2
            var value = nums[middle]
            if value == target{
                return middle
            }
            if value > target{
                max = middle - 1// -1/+1 важно иначе может получиться бесконечный луп, да и зачем проверять это значение, если оно уже было проверено?
            } else {
                min = middle + 1
            }
        }
        return -1
    }
}

let some = Solution()
var nums = [-1,0,3,5,9,12,100,151,81,65,-192,-329,9999,7,3,21,-9999,10000]
nums.sort()
print(nums)
let target = 100
print(some.search(nums, target))
//: [Next](@next)
