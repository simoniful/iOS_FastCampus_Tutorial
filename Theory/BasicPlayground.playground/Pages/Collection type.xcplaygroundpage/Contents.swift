//: [Previous](@previous)

import Foundation

var numbers: Array<Int> = Array<Int>()
numbers.append(1)
numbers.append(2)
numbers.append(3)

numbers[0]
numbers[1]

numbers.insert(4, at: 2)
numbers

numbers.remove(at: 0)
numbers

// var dic: Dictionary<String, Int> = Dictionary<String, Int>()
var dict: [String: Int] = ["권성동": 53, "박성용": 36]
dict["이상훈"] = 32
dict["김민지"] = 31
dict

dict["김민지"] = 36
dict

dict.removeValue(forKey: "김민지")
dict

var set: Set<Int> = Set<Int>()

set.insert(10)
set.insert(20)
set.insert(30)
set.insert(30)
set

set.remove(20)
set
//: [Next](@next)
