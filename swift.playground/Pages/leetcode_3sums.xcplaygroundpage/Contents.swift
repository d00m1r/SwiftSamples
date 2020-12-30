//: [Previous](@previous)

import Foundation

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int]? {
        var dict = [Int:Int]()
        for (index,value) in nums.enumerated(){
            if let lastIndex = dict[target-value]{
                return[lastIndex,index]
            }
            dict[value] = index
        }
        return nil
    }
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var resultArr:[[Int]] = []
        var resultDic:[Int:Bool]
        var numsSet: Set<Set<Int>> = []
        for index in nums.indices{
            var tempNums:[Int] = nums
            let target = -nums[index]
            tempNums.remove(at: index)
            if let indices = twoSum(tempNums, target) {
                var threeNumsSet:Set = [nums[index], tempNums[indices[0]], tempNums[indices[1]]]
                //if !numsSet.contains(threeNumsSet) {
                    resultArr.append([nums[index], tempNums[indices[0]], tempNums[indices[1]]])
                    numsSet.insert(threeNumsSet)
                //}
            }
        }
        return resultArr
    }
}
//var nums = [-1,0,1,2,-1,-4]
//[[-1,-1,2],[-1,0,1]]

var nums = [-1,0,1,2,-1,-4,-2,-3,3,0,4]
//[[-4,0,4]*,[-4,1,3]*,[-3,-1,4]?,[-3,0,3]?,[-3,1,2]*,[-2,-1,3]?,[-2,0,2]*,[-1,-1,2]*,[-1,0,1]*]

//var target = 0//a + b + c = 0
var some = Solution()
print("result:",some.threeSum(nums))

//: [Next](@next)
