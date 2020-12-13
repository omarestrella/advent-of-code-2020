//
//  day13.swift
//  Advent2020
//
//  Created by Omar Estrella on 12/13/20.
//

import Foundation

fileprivate func departingTimes(busId: Int, count: Int) -> [Int] {
  return Array(repeating: busId, count: count).enumerated().map { (idx, num) in idx * num }
}

fileprivate func part1(timestamp: Int, busIds: [Int]) -> Int {
  let departures = busIds.map { busId -> (Int, Int) in
    let ids = departingTimes(busId: busId, count: timestamp).filter { $0 > timestamp }
    return (busId, ids.first!)
  }
  let data = departures.sorted(by: { $0.1 < $1.1 }).first!
  let timeToWait = data.1 - timestamp
  return data.0 * timeToWait
}

fileprivate func part2() {}

fileprivate let input = """
939
7,13,x,x,59,x,31,19
"""

func day13() {
  let input = getInput(day: 13)
  let data = input.split(separator: "\n")
  let timestamp = Int(data[0])!
  let busIds = data[1].split(separator: ",").compactMap { id -> Int? in
    if let id = Int(id) {
      return id
    }
    return nil
  }
  
  print("Part 1: \(part1(timestamp: timestamp, busIds: busIds))")
  print("Part 2: \(part2())")
}
