// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import UIKit

extension UIEdgeInsets: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(top)
    hasher.combine(left)
    hasher.combine(bottom)
    hasher.combine(right)
  }
}
