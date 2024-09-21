// Created by Aleksei Smirnov on 09/05/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Foundation

extension Swift.Collection {
  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  public subscript(safe index: Index) -> Element? {
    guard index >= startIndex, endIndex > index else { return nil }
    return self[index]
  }
}

extension Collection where Element: Equatable & Decodable {
  public func applying(_ changes: Change<Element>) -> [Element] {
    var result = ContiguousArray(self)
    result.reserveCapacity(result.count - changes.removals.count + changes.insertions.count)

    // Removals
    for element in changes.removals {
      if let index = result.firstIndex(of: element) {
        result.remove(at: index)
      }
    }

    // Insert
    result.append(contentsOf: changes.insertions)

    // Move
    for move in changes.moves {
      if move.from < result.count, move.to < result.count {
        let element = result.remove(at: move.from)
        result.insert(element, at: move.to)
      }
    }

    // Update
    for update in changes.updates {
      if update.index < result.count {
        result[update.index] = update.newValue
      }
    }

    return Array(result)
  }
}
