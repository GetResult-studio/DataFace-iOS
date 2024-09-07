// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import protocol DataFaceUI.ListItemsFactoryProtocol
import protocol EpoxyCollectionView.ItemModeling
import UIKit

// MARK: - ListItemsFactory

final class ListItemsFactory {

  private func buildLabel(
    collectionViewSize: CGSize,
    dataID: AnyHashable,
    content: Data,
    style: Data)
    -> (any ItemModeling)?
  {
    guard let content: CustomLabel.Content = CustomLabel.decodeContent(data: content) else {
      return nil
    }

    guard let style: CustomLabel.Style = CustomLabel.decodeStyle(data: style) else {
      return nil
    }

    let width = collectionViewSize.width
    let height = CustomLabel.height(for: width, with: content, and: style)

    return CustomLabel.itemModel(dataID: dataID, content: content, style: style)
      .flowLayoutItemSize(.init(width: width, height: height))
  }
}

// MARK: ListItemsFactoryProtocol

extension ListItemsFactory: ListItemsFactoryProtocol {

  func makeItem(
    collectionViewSize: CGSize,
    dataID: AnyHashable,
    type: String,
    content: Data,
    style: Data)
    -> (any ItemModeling)?
  {
    switch type {
    case "custom_label":
      return buildLabel(
        collectionViewSize: collectionViewSize,
        dataID: dataID,
        content: content,
        style: style)

    default:
      return nil
    }
  }
}
