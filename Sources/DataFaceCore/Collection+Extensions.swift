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
