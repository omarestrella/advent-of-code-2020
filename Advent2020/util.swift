//
//  util.swift
//  Advent2020
//
//  Created by Omar Estrella on 12/7/20.
//

import Foundation

private func getToken() -> String {
  guard let path = Bundle.main.path(forResource: "config", ofType: "plist") else { return "" }
  let url = URL(fileURLWithPath: path)
  let data = try! Data(contentsOf: url)
  let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String: String]
  return plist["session"] ?? ""
}

func getInput(day: Int) -> String {
  let path = URL(fileURLWithPath: "input/day\(day).txt", relativeTo: URL(string: "file://\(FileManager.default.currentDirectoryPath)"))
  let data = try! Data(contentsOf: path)
  return String(data: data, encoding: .utf8)!
}
