// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import protocol DataFaceUI.CustomItemsFactoryProtocol
import protocol EpoxyCollectionView.ItemModeling
import protocol EpoxyCollectionView.SupplementaryItemModeling
import UIKit

// MARK: - CustomItemsFactoryDelegate

protocol CustomItemsFactoryDelegate: AnyObject {
  func didSelectLabel(dataID: AnyHashable)
}

// MARK: - CustomItemsFactory

final class CustomItemsFactory {

  // MARK: Internal

  weak var delegate: CustomItemsFactoryDelegate?

  // MARK: Private

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
      .didSelect { [weak self] _ in
        self?.delegate?.didSelectLabel(dataID: dataID)
      }
  }

  private func buildSpinnerView(
    dataID: AnyHashable)
    -> (any ItemModeling)?
  {
    SpinnerView.itemModel(dataID: dataID)
      .selectionStyle(.noBackground)
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

    case "spinner_view":
      return buildSpinnerView(dataID: dataID)

    default:
      return nil
    }
  }
}
