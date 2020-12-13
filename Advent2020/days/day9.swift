//
//  day9.swift
//  Advent2020
//
//  Created by Omar Estrella on 12/9/20.
//

import Foundation

fileprivate func part1(_ numbers: [Int]) {
  print(numbers.prefix(5))
}

fileprivate func part2(_ numbers: [Int]) {
  
}

let testInput = """
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"""

func day9() {
  let numbers = testInput//getInput(day: 8)
    .split(separator: "\n")
    .map { Int($0)! }
  print("Part 1: \(part1(numbers))")
  print("Part 2: \(part2(numbers))")
}
