// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import UIKit

/// A protocol that defines the contract for creating list items in a collection view.
public protocol ListItemsFactoryProtocol: AnyObject {

  /// Creates an item model for the collection view.
  ///
  /// - Parameters:
  ///   - collectionViewSize: The size of the collection view in which the item will be displayed.
  ///   - dataID: A unique identifier for the item, used to track the data.
  ///   - content: The content data used to configure the item.
  ///   - style: The style data used to apply visual styling to the item.
  ///
  /// - Returns: An optional `ItemModeling` instance, which represents the item to be displayed in the collection view. If `nil` is returned, no item will be created for the given inputs.
  func makeItem(
    collectionViewSize: CGSize,
    dataID: AnyHashable,
    type: String,
    content: Data,
    style: Data) -> ItemModeling?
}
