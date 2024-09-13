// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import EpoxyCore
import UIKit

// MARK: - DFHostViewFactory

final class DFHostViewFactory {

  // MARK: Lifecycle

  init(customItemsFactory: CustomItemsFactoryProtocol?) {
    self.customItemsFactory = customItemsFactory
  }

  // MARK: Private

  private let customItemsFactory: CustomItemsFactoryProtocol?

  private func makeSupplementaryView(for item: DFHostViewModel.Item?) -> [any SupplementaryItemModeling]? {
    guard let item else { return nil }

    switch item.style.type {
    case .dummyView(let styleDTO):
      guard
        let content = {
          if case .dummyView(let data) = item.content { return data.uiContent } else { return nil }
        }()
      else {
        return nil
      }

      return [
        DummyView.supplementaryItemModel(
          dataID: item.dataID,
          content: content,
          style: styleDTO.uiStyle),
      ]

    case .custom(let name, let styleData):
      EpoxyLogger.shared.assert(
        customItemsFactory != nil, "Custom doesn't work without customItemsFactory")

      let content = {
        if case .custom(let data) = item.content { return data } else { return nil }
      }()

      guard let content, let styleData, !name.isEmpty else { return nil }

      return customItemsFactory?.makeSupplementaryItem(
        dataID: item.dataID,
        type: name,
        content: content,
        style: styleData)
    }
  }

}

// MARK: DFHostViewFactoryProtocol

extension DFHostViewFactory: DFHostViewFactoryProtocol {

  func makeItem(from item: DFHostViewModel.Item?) -> (any ItemModeling)? {
    guard let item else { return nil }
    switch item.style.type {
    case .dummyView(let styleDTO):
      guard
        let content = {
          if case .dummyView(let data) = item.content { return data.uiContent } else { return nil }
        }()
      else {
        return nil
      }

      return DummyView.itemModel(
        dataID: item.dataID,
        content: content,
        style: styleDTO.uiStyle)

    case .custom(let name, let styleData):
      EpoxyLogger.shared.assert(
        customItemsFactory != nil,
        "Custom doesn't work without listItemsFactory")

      let content = {
        if case .custom(let val) = item.content { return val } else { return nil }
      }()

      guard let content, let styleData, !name.isEmpty else { return nil }

      return customItemsFactory?.makeItem(
        dataID: item.dataID,
        type: name,
        content: content,
        style: styleData)
    }
  }

  func makeSupplementaryViewHeaderFooter(
    from headerFooter: DFHostViewModel.Section.HeaderFooter?)
    -> [any SupplementaryItemModeling]?
  {
    guard let headerFooter else { return nil }
    return makeSupplementaryView(for: headerFooter.content)
  }

  func makeSupplementaryViewBackground(
    from background: DFHostViewModel.Section.Background?)
    -> [any SupplementaryItemModeling]?
  {
    guard let background else { return nil }
    return makeSupplementaryView(for: background.content)
  }
}
