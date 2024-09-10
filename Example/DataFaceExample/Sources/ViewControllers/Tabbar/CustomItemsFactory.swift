// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import protocol DataFaceUI.CustomItemsFactoryProtocol
import protocol EpoxyCollectionView.ItemModeling
import protocol EpoxyCollectionView.SupplementaryItemModeling
import UIKit

// MARK: - CustomItemsFactory

final class CustomItemsFactory {

  private func buildLabel(
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

    return CustomLabel.itemModel(dataID: dataID, content: content, style: style)
  }
}

// MARK: CustomItemsFactoryProtocol

extension CustomItemsFactory: CustomItemsFactoryProtocol {
  func makeItem(
    dataID: AnyHashable,
    type: String,
    content: Data,
    style: Data)
    -> (any ItemModeling)?
  {
    switch type {
    case "custom_label":
      return buildLabel(
        dataID: dataID,
        content: content,
        style: style)

    default:
      return nil
    }
  }
}
