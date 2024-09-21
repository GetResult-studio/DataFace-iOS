// Created by Aleksei Smirnov on 09/21/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

// MARK: - Move

public struct Move<T: Decodable>: Decodable {
  public let from: Int
  public let to: Int
}

// MARK: - Update

public struct Update<T: Decodable>: Decodable {
  public let index: Int
  public let newValue: T
}

// MARK: - Change

public struct Change<T: Decodable>: Decodable {
  public let insertions: [T]
  public let removals: [T]
  public let moves: [Move<T>]
  public let updates: [Update<T>]
}
