//: [Previous](@previous)

import Foundation

extension Array{
    mutating func mySwap(_ i: Int, _ j: Int) {
        let t = self[i]
        self[i] = self[j]
        self[j] = t
    }
}

func bubbleSort (_ arr: [Int])->[Int]{//O(n^2)
    let size = arr.count
    var out = arr
    guard !(size < 2) else { return arr }
    for elem in 0..<size{
        let itemsLeft = size - 1 - elem
        for index in 0..<itemsLeft{
            if out[index] > out[index+1]{
                out.mySwap(index, index+1)
            }
        }
    }
    return out
}

//подсчет элементов в массиве
func countingSort (_ arr: [Int])->[Int]{//O(n), но только с целыми num >=0 и создаются доп массивы
    guard !arr.isEmpty else { return [] }
    let maxValue = arr.max()!
    let minValue = arr.min()!
    let size = maxValue + 1
    var arrayOfEntries = [Int](repeating: 0, count:size)
    for elem in arr{
        arrayOfEntries[elem] += 1
    }
    var out:[Int] = []
    for elem in minValue..<size{
        for _ in 0..<arrayOfEntries[elem]{
            out.append(elem)
        }
    }
    return out
}

//делим на 2 части: по аналогии с insertionSort
func selectionSort (_ arr:[Int])->[Int]{//O(n^2)
    let size = arr.count
    var out = arr
    guard !(size < 2) else { return arr }
    for elem in 0..<size{//поиск по минимуму
        var index = elem
        while index < size - 1{
            index += 1
            if out[elem] > out[index]{
                out.mySwap(elem, index)
            }
        }
    }
    return out
}

//делим на 2 части: отсортированное начало и последующий массив
func insertionSort(_ arr:[Int])->[Int]{//O(n^2)
    guard !(arr.count < 2) else { return arr }
    var out = arr
    for elem in 1..<arr.count{
        //var insertionItem = out[index]
        var index = elem
        while index > 0 && out[index] < out[index-1] {
            out.mySwap(index, index-1)
            index -= 1
        }
    }
    return out
}

func quickSort (_ arr:[Int])->[Int]{//O(n*logn) in best case~middle case
    //O(n^2) in bad case
    guard !(arr.count < 2) else { return arr }
    let selectedItem = arr[0]
    let less = arr[1..<arr.count].filter { $0 <= selectedItem }
    let greater = arr[1..<arr.count].filter { $0 > selectedItem }
    return quickSort(less) + [selectedItem] + quickSort(greater)
}

func mergeSort (_ arr:[Int])->[Int]{//O(n*logn), расходы на память
    guard !(arr.count < 2) else { return arr }
    let half = Int(arr.count/2)
    return merge(mergeSort(Array(arr[0..<half])),mergeSort(Array(arr[half..<arr.count])))
}
func merge(_ arr1:[Int],_ arr2:[Int]) ->[Int]{
    guard !arr1.isEmpty else { return arr2 }
    guard !arr2.isEmpty else { return arr1 }
    if arr1[0]<=arr2[0]{
        return [arr1[0]] + merge(Array(arr1[1..<arr1.count]), arr2)
    } else {
        return [arr2[0]] + merge(arr1, Array(arr2[1..<arr2.count]))
    }
}

enum Sortings:CaseIterable{
    case bubble
    case selection
    case insertion
    case counting
    case quick
    case merge
    
    func sort(_ arr: [Int]){
        switch self {
        case .bubble:
            print("BubbleSort: \(bubbleSort(arr))")
        case .selection:
            print("SelectionSort: \(selectionSort(arr))")
        case .insertion:
            print("InsertionSort: \(insertionSort(arr))")
        case .counting:
            print("CountingSort: \(countingSort(arr))")
        case .quick:
            print("QuickSort: \(quickSort(arr))")
        case .merge:
            print("MergeSort: \(mergeSort(arr))")
        }
    }
}
var arr = [99,11,1,2,3,7,0,-100,101,102,103,100,17,-1,1]
var arrPositive = [99,11,12,35,7,7,7,100,17]

for sort in Sortings.allCases{
    guard sort != .counting else { continue }
    sort.sort(arr)
}
var someSort = Sortings.counting
someSort.sort(arrPositive)

//: [Next](@next)


