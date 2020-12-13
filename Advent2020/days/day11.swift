//
//  day11.swift
//  Advent2020
//
//  Created by Omar Estrella on 12/11/20.
//

import Foundation

enum Seat: Equatable {
  case Floor
  case Empty
  case Occupied
  
  static func fromString(str: String) -> Seat {
    if str == "." {
      return .Floor
    } else if str == "L" {
      return .Empty
    } else {
      return .Occupied
    }
  }
  
  var display: String {
    switch self {
    case .Floor:
      return "."
    case .Empty:
      return "L"
    case .Occupied:
      return "#"
    }
  }
}

typealias Position = (Int, Int)

fileprivate func height(seats: [[Seat]]) -> Int {
  return seats.count
}

fileprivate func width(seats: [[Seat]]) -> Int {
  return seats[0].count
}

fileprivate func adjacentPositions(pos: Position, seats: [[Seat]]) -> [Position] {
  let (x, y) = pos
  let positions = [
    (x - 1, y - 1), (x, y - 1), (x + 1, y - 1),
    (x - 1, y), (x + 1, y),
    (x - 1, y + 1), (x, y + 1), (x + 1, y + 1)
  ].filter { (x, y) in
    return x >= 0 && y >= 0 && x < height(seats: seats) && y < width(seats: seats)
  }
  return positions
}

fileprivate func adjacentSeats(pos: Position, seats: [[Seat]]) -> [Seat] {
  let positions = adjacentPositions(pos: pos, seats: seats)
  return positions.map { (x, y) in
    return seats[x][y]
  }
}

fileprivate func run(_ data: [[Seat]]) -> [[Seat]] {
  return data.enumerated().map { (row, seats) in
    return seats.enumerated().map { (col, seat) in
      let pos = (row, col)
      let adjacent = adjacentSeats(pos: pos, seats: data)
      let occupiedSeats = adjacent.filter { $0 == .Occupied }
      if seat == .Empty && occupiedSeats.count == 0 {
        return .Occupied
      } else if seat == .Occupied && occupiedSeats.count >= 4 {
        return .Empty
      } else {
        return seat
      }
    }
  }
}

fileprivate func equal(_ a: [[Seat]], _ b: [[Seat]]) -> Bool {
  return zip(a, b).allSatisfy { aSeats, bSeats in
    return zip(aSeats, bSeats).allSatisfy { $0 == $1 }
  }
}

fileprivate func display(_ seats: [[Seat]]) {
  seats.forEach { seats in
    print(seats.map { seat in
      return seat.display
    }.joined(separator: ""))
  }
}

fileprivate func part1(_ seats: [[Seat]]) -> Int {
  var seats = seats
  var newSeats = run(seats)
  while true {
    if equal(seats, newSeats) {
      break;
    }
    seats = newSeats
    newSeats = run(newSeats)
  }
  return newSeats.reduce(0) { count, seats in
    return count + seats.filter { $0 == .Occupied }.count
  }
}

fileprivate func part2() {
  
}

fileprivate let input = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"""

func day11() {
  let input = getInput(day: 11)
  let data = input.split(separator: "\n").map { line -> [Seat] in
    return line.map {
      Seat.fromString(str: String($0))
    }
  }
  print("Part 1: \(part1(data))")
  print("Part 2: \(part2())")
}
