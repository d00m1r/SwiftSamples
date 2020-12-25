//: [Previous](@previous)
//Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
import Foundation
//brute force неоптимально по памяти, в любое случае по
//ARRAY for in array Time O(n^2), memory O(n)
//DIC Time O(n), memory O(n) создаем словарь и подсчитываем вхождения
//SET return 2 * sum(set(nums)) - sum(nums) time O(n), memory O(n)
//Оптимально Bit Manipulation Time O(n), memory O(1)!!!!!
class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var num = 0
        for el in nums{
            num = num ^ el
        }//If we take XOR of zero and some bit, it will return that bit
        //a⊕0=a
        //If we take XOR of two same bits, it will return 0
        //a⊕a=0
        return num
    }
}
let nums = [1,1,2,7,5,2,5]
let some = Solution()
print(some.singleNumber(nums))
//: [Next](@next)
