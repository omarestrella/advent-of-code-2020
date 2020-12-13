//
//  day10.swift
//  Advent2020
//
//  Created by Omar Estrella on 12/11/20.
//

import Foundation

fileprivate func part1(_ voltages: [Int]) -> Int {
  let sorted = voltages.sorted()
  var oneDiff = 0
  var threeDiff = 0
  for (idx, voltage) in sorted.enumerated() {
    var compare = -1
    if idx == sorted.count - 1 {
      compare = sorted[idx]
    } else {
      compare = sorted[idx + 1]
    }
    if voltage + 1 == compare {
      oneDiff += 1
    } else {
      threeDiff += 1
    }
  }
  print(oneDiff + 1, threeDiff)
  return (oneDiff + 1) * threeDiff
}

fileprivate func part2(_ voltages: [Int]) {
  let max = voltages.last!
  
}

fileprivate let input = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""


func day10() {
//  let input = getInput(day: 10)
  let voltages = input.split(separator: "\n").map { Int($0)! }
  print("Part 1: \(part1(voltages))")
  print("Part 2: \(part2(voltages))")
}
