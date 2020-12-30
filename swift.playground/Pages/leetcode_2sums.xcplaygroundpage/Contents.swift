//: [Previous](@previous)
import Foundation
//O(1) благодаря хэш-картам
//ключами словарей являются числа, значениями - индексы,[num1:0,num2:1,...]
//в случае, если ключ уже существует, но сумма одинаковых ключей не даёт верного ответа,
//то перезаписываем, существует и ! верный ответ, учитывать перезапись.
class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int:Int]()
        for (index,value) in nums.enumerated(){
            if let lastIndex = dict[target-value]{
                return[lastIndex,index]
            }
            //dict[value] ? continue : dict[value] = index
//            if let t = dict[value]{
//                continue
//            }else{
                dict[value] = index
//            }
            print(dict)
        }
        return []
    }
}
var nums = [3,3,2]//на выходе получаем не (0,2), а (1,2)
var target = 5
var some = Solution()
print("result: "some.twoSum(nums, target))
//: [Next](@next)
