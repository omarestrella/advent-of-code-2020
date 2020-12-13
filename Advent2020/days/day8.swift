//
//  day8.swift
//  Advent2020
//
//  Created by Omar Estrella on 12/9/20.
//

import Foundation

func function(for str: String) -> (_: Int, _: Int) -> Int {
  switch str {
  case "+":
    return (+)
  case "-":
    return (-)
  default:
    return (+)
  }
}

enum Instruction {
  case Add(op: (_: Int, _: Int) -> Int, amount: Int)
  case Jump(op: (_: Int, _: Int) -> Int, spaces: Int)
  case NoOp(op: (_: Int, _: Int) -> Int, amount: Int)
  
  init(instruction: String, op operation: String, amount: String) {
    switch instruction {
    case "acc":
      self = .Add(op: function(for: operation), amount: Int(amount)!)
    case "jmp":
      self = .Jump(op: function(for: operation), spaces: Int(amount)!)
    default:
      self = .NoOp(op: function(for: operation), amount: Int(amount)!)
    }
  }
}

func swapInstruction(instruction: Instruction) -> Instruction {
  switch instruction {
  case .NoOp(let op, let amount):
    return .Jump(op: op, spaces: amount)
  case .Jump(let op, let spaces):
    return .NoOp(op: op, amount: spaces)
  default:
    return instruction
  }
}

func runInstructions(_ instructions: [Instruction]) -> (Int, Bool) {
  var visitedInstructions: [Int] = []
  var total = 0
  var currentInstruction = 0
  var success = false
  while true {
    if visitedInstructions.contains(where: { $0 == currentInstruction }) {
      break;
    }
    if currentInstruction < 0 || currentInstruction >= instructions.count {
      return (total, success)
    }
    let i = instructions[currentInstruction]
    visitedInstructions.append(currentInstruction)
    switch i {
    case .Add(let op, let amount):
      total = op(total, amount)
      currentInstruction += 1
    case .Jump(let op, let spaces):
      currentInstruction = op(currentInstruction, spaces)
    case .NoOp:
      currentInstruction += 1
    }
    if currentInstruction == instructions.count - 1 {
      success = true
    }
  }
  return (total, success)
}

fileprivate func part1(_ instructions: [Instruction]) -> Int {
  let (total, _) = runInstructions(instructions)
  return total
}

fileprivate func part2(_ instructions: [Instruction]) -> Int {
  var answer = 0
  for (idx, inst) in instructions.enumerated() {
    var cloned = instructions
    let newInst = swapInstruction(instruction: inst)
    cloned[idx] = newInst
    let (total, success) = runInstructions(cloned)
    if success {
      answer = total
      break;
    }
  }
  return answer
}

func day8() {
  let instructions = getInput(day: 8)
    .split(separator: "\n")
    .map { str -> Instruction in
      let matches = String(str).matches(pattern: #"(\w+) (\+|\-)(\d+)"#)
      return Instruction(instruction: matches[0], op: matches[1], amount: matches[2])
    }
  print("Part 1: \(part1(instructions))")
  print("Part 2: \(part2(instructions))")
}


