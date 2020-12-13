//
//  day12.swift
//  Advent2020
//
//  Created by Omar Estrella on 12/11/20.
//

import Foundation

enum Direction {
  case East
  case North
  case South
  case West
  
  static func turn(current: Direction, to: String, amount: Int) -> Direction {
    switch current {
    case .East:
      if to == "R" {
        if amount == 90 {
          return .South
        }
        if amount == 180 {
          return .West
        }
        if amount == 270 {
          return .North
        }
        return .East
      }
      if to == "L" {
        if amount == 90 {
          return .North
        }
        if amount == 180 {
          return .West
        }
        if amount == 270 {
          return .South
        }
        return .East
      }
    case .North:
      if to == "R" {
        if amount == 90 {
          return .East
        }
        if amount == 180 {
          return .South
        }
        if amount == 270 {
          return .West
        }
        return .North
      }
      if to == "L" {
        if amount == 90 {
          return .West
        }
        if amount == 180 {
          return .South
        }
        if amount == 270 {
          return .East
        }
        return .North
      }
    case .West:
      if to == "R" {
        if amount == 90 {
          return .North
        }
        if amount == 180 {
          return .East
        }
        if amount == 270 {
          return .South
        }
        return .West
      }
      if to == "L" {
        if amount == 90 {
          return .South
        }
        if amount == 180 {
          return .East
        }
        if amount == 270 {
          return .North
        }
        return .West
      }
    case .South:
      if to == "R" {
        if amount == 90 {
          return .West
        }
        if amount == 180 {
          return .North
        }
        if amount == 270 {
          return .East
        }
        return .South
      }
      if to == "L" {
        if amount == 90 {
          return .East
        }
        if amount == 180 {
          return .North
        }
        if amount == 270 {
          return .West
        }
        return .South
      }
    }
    print("Got something weird")
    return current
  }
  
  static func rotate(waypoint: (Int, Int), to: String, amount: Int) -> (Int, Int) {
    let (x, y) = waypoint
    if to == "R" {
      if amount == 90 {
        return (y, -x)
      }
      if amount == 180 {
        return (-x, -y)
      }
      if amount == 270 {
        return (-y, x)
      }
      return (x, y)
    } else {
      if amount == 90 {
        return (-y, x)
      }
      if amount == 180 {
        return (-x, -y)
      }
      if amount == 270 {
        return (y, -x)
      }
      return (x, y)
    }
  }
}

fileprivate func part1(_ input: [(String, Int)]) -> Int {
  var direction = Direction.East
  var pos = (0, 0)
  input.forEach { (dir, num) in
    var (x, y) = pos
    switch dir {
    case "N":
      y += num
      break;
    case "S":
      y -= num
      break
    case "E":
      x += num
      break
    case "W":
      x -= num
      break
    case "L":
      direction = Direction.turn(current: direction, to: "L", amount: num)
      break
    case "R":
      direction = Direction.turn(current: direction, to: "R", amount: num)
      break
    case "F":
      switch direction {
      case .East:
        x += num
        break
      case .North:
        y += num
      case .South:
        y -= num
      case .West:
        x -= num
      }
      break
    default:
      print("Got something weird")
    }
    pos = (x, y)
  }
  print(pos)
  let (x, y) = pos
  return abs(x) + abs(y)
}

fileprivate func part2(_ input: [(String, Int)]) -> Int {
  var pos = (0, 0)
  var waypoint = (10, 1)
  input.forEach { (dir, num) in
    var (x, y) = pos
    var (waypointX, waypointY) = waypoint
    switch dir {
    case "N":
      waypointY += num
      break;
    case "S":
      waypointY -= num
      break
    case "E":
      waypointX += num
      break
    case "W":
      waypointX -= num
      break
    case "L":
      (waypointX, waypointY) = Direction.rotate(waypoint: waypoint, to: "L", amount: num)
      break
    case "R":
      (waypointX, waypointY) = Direction.rotate(waypoint: waypoint, to: "R", amount: num)
      break
    case "F":
      x += waypointX * num
      y += waypointY * num
      break
    default:
      print("Got something weird")
    }
    pos = (x, y)
    waypoint = (waypointX, waypointY)
  }
  print(pos)
  let (x, y) = pos
  return abs(x) + abs(y)
}

fileprivate let input = """
F10
N3
F7
R90
F11
"""

func day12() {
  let input = getInput(day: 12)
  let directions = input
    .split(separator: "\n")
    .map { str -> (String, Int) in
      let dir = String(str.first!)
      let num = Int(str[str.index(str.startIndex, offsetBy: 1)..<str.endIndex])!
      return (dir, num)
    }
  print("Part 1: \(part1(directions))")
  print("Part 2: \(part2(directions))")
}
