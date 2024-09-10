// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import UIKit

// MARK: - CustomItemsFactoryProtocol

/// A protocol that defines the contract for creating custom items in a collection view.
public protocol CustomItemsFactoryProtocol: AnyObject {

  /// Creates an custom item model for the collection view.
  ///
  /// - Parameters:
  ///   - dataID: A unique identifier for the item, used to track the data.
  ///   - content: The content data used to configure the item.
  ///   - style: The style data used to apply visual styling to the item.
  ///
  /// - Returns: An optional `ItemModeling` instance, which represents the item to be displayed in the collection view. If `nil` is returned, no item will be created for the given inputs.
  func makeItem(
    dataID: AnyHashable,
    type: String,
    content: Data,
    style: Data) -> ItemModeling?

  /// Creates an custom supplementary item model for the collection view. This is optional method and return nil by default.
  ///
  /// - Parameters:
  ///   - dataID: A unique identifier for the supplementary item, used to track the data.
  ///   - content: The content data used to configure the supplementary item.
  ///   - style: The style data used to apply visual styling to the supplementary item.
  ///
  /// - Returns: An optional `SupplementaryItemModeling` instance, which represents the supplementary item to be displayed in the collection view. If `nil` is returned, no supplementary item will be created for the given inputs.
  func makeSupplementaryItem(
    dataID: AnyHashable,
    type: String,
    content: Data,
    style: Data)
    -> [SupplementaryItemModeling]?
}

extension CustomItemsFactoryProtocol {
  public func makeSupplementaryItem(
    dataID _: AnyHashable,
    type _: String,
    content _: Data,
    style _: Data)
    -> [SupplementaryItemModeling]?
  {
    nil
  }
}
