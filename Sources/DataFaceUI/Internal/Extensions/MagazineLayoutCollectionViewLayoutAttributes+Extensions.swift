// Created by Aleksei Smirnov on 09/08/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Epoxy
import MagazineLayout
import UIKit

extension MagazineLayoutCollectionViewLayoutAttributes: FittingPrioritiesProvidingLayoutAttributes {
  public var horizontalFittingPriority: UILayoutPriority {
    .required
  }

  public var verticalFittingPriority: UILayoutPriority {
    .fittingSizeLevel
  }
}
