// Created by Aleksei Smirnov on 09/08/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import MagazineLayout
import UIKit

// MARK: - DFHostViewController + UICollectionViewDelegateMagazineLayout

extension DFHostViewController: UICollectionViewDelegateMagazineLayout {

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    sizeModeForItemAt indexPath: IndexPath)
    -> MagazineLayoutItemSizeMode
  {
    let size = viewModel.sections[indexPath.section].content[indexPath.row].style.size
    let widthMode = size.width.widthMode
    let heightMode = size.height.heightMode
    return MagazineLayoutItemSizeMode(
      widthMode: widthMode,
      heightMode: heightMode)
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    visibilityModeForHeaderInSectionAtIndex _: Int)
    -> MagazineLayoutHeaderVisibilityMode
  {
    .hidden
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    visibilityModeForFooterInSectionAtIndex _: Int)
    -> MagazineLayoutFooterVisibilityMode
  {
    .hidden
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    visibilityModeForBackgroundInSectionAtIndex _: Int)
    -> MagazineLayoutBackgroundVisibilityMode
  {
    .hidden
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    horizontalSpacingForItemsInSectionAtIndex index: Int)
    -> CGFloat
  {
    viewModel.sections[safe: index]?.style.hSpacing ?? 8
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    verticalSpacingForElementsInSectionAtIndex index: Int)
    -> CGFloat
  {
    viewModel.sections[safe: index]?.style.vSpacing ?? 8
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    insetsForSectionAtIndex index: Int)
    -> UIEdgeInsets
  {
    viewModel.sections[safe: index]?.style.insets?.uiEdgeInsets ?? .init(top: 8, left: 8, bottom: 8, right: 8)
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    insetsForItemsInSectionAtIndex index: Int)
    -> UIEdgeInsets
  {
    viewModel.sections[safe: index]?.style.itemsInsets?.uiEdgeInsets ?? .init(top: 8, left: 8, bottom: 8, right: 8)
  }
}

extension DFHostViewModel.Item.Style.Size.Width {
  fileprivate var widthMode: MagazineLayoutItemWidthMode {
    switch self {
    case .fullWidth(let respectsHorizontalInsets):
      return .fullWidth(respectsHorizontalInsets: respectsHorizontalInsets)

    case .fractional(let divisor):
      return .fractionalWidth(divisor: divisor)
    }
  }
}

extension DFHostViewModel.Item.Style.Size.Height {
  fileprivate var heightMode: MagazineLayoutItemHeightMode {
    switch self {
    case .dynamic:
      return .dynamic

    case .dynamicWithEstimatedHeight(let estimatedHeight):
      return .dynamic(estimatedHeight: estimatedHeight)

    case .dynamicAndStretchToTallestItemInRow:
      return .dynamicAndStretchToTallestItemInRow

    case .static(let height):
      return .static(height: height)
    }
  }
}
