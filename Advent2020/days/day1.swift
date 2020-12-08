//
//  day1.swift
//  Advent2020
//
//  Created by Omar Estrella on 12/7/20.
//

import Foundation
import Algorithms

private func part1(numbers: [Int]) -> Int {
  return numbers.filter {
    numbers.contains(2020 - $0)
  }.reduce(1, *)
}

private func part2(numbers: [Int]) -> Int {
  return numbers.combinations(ofCount: 3).filter {
    $0.reduce(0, +) == 2020
  }
  .first?
  .reduce(1, *) ?? 0
}

func day1() {
  let numbers = getInput(day: 1).split(separator: "\n").compactMap { Int($0) }
  print("Part 1: \(part1(numbers: numbers))")
  print("Part 2: \(part2(numbers: numbers))")
}
