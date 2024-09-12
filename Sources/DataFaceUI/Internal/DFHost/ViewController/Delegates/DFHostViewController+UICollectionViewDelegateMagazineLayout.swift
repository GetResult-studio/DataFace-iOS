// Created by Aleksei Smirnov on 09/08/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import EpoxyCore
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
    let size = viewModel.sections[safe: indexPath.section]?.content[safe: indexPath.row]?.style.size

    EpoxyLogger.shared.assert(
      size != nil,
      "Possible error: size probably shouldn't be nil. Fallback to MagazineLayout.Default.ItemSizeMode")

    let widthMode = size?.width?.widthMode ?? MagazineLayout.Default.ItemSizeMode.widthMode
    let heightMode = size?.height.heightMode ?? MagazineLayout.Default.ItemSizeMode.heightMode
    return MagazineLayoutItemSizeMode(
      widthMode: widthMode,
      heightMode: heightMode)
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    visibilityModeForHeaderInSectionAtIndex index: Int)
    -> MagazineLayoutHeaderVisibilityMode
  {
    guard let heightMode = viewModel.sections[safe: index]?.header?.content.style.size?.height.headerHeightMode else {
      EpoxyLogger.shared.assert(
        viewModel.sections[safe: index]?.header != nil,
        "It looks like you want to display the header, but it won't be visible.")
      return .hidden
    }

    let pinToVisibleBounds = viewModel.sections[safe: index]?.header?.style.pinToVisibleBounds ?? false

    return .visible(heightMode: heightMode, pinToVisibleBounds: pinToVisibleBounds)
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
    visibilityModeForBackgroundInSectionAtIndex index: Int)
    -> MagazineLayoutBackgroundVisibilityMode
  {
    viewModel.sections[safe: index]?.background == nil ? .hidden : .visible
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    horizontalSpacingForItemsInSectionAtIndex index: Int)
    -> CGFloat
  {
    viewModel.sections[safe: index]?.style.hSpacing ?? MagazineLayout.Default.HorizontalSpacing
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    verticalSpacingForElementsInSectionAtIndex index: Int)
    -> CGFloat
  {
    viewModel.sections[safe: index]?.style.vSpacing ?? MagazineLayout.Default.VerticalSpacing
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    insetsForSectionAtIndex index: Int)
    -> UIEdgeInsets
  {
    viewModel.sections[safe: index]?.style.insets?.uiEdgeInsets ?? MagazineLayout.Default.SectionInsets
  }

  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    insetsForItemsInSectionAtIndex index: Int)
    -> UIEdgeInsets
  {
    viewModel.sections[safe: index]?.style.itemsInsets?.uiEdgeInsets ?? MagazineLayout.Default.ItemInsets
  }
}

extension StyleDTO.Size.Width {
  fileprivate var widthMode: MagazineLayoutItemWidthMode {
    switch self {
    case .fullWidth(let respectsHorizontalInsets):
      return .fullWidth(respectsHorizontalInsets: respectsHorizontalInsets)

    case .fractional(let divisor):
      return .fractionalWidth(divisor: divisor)
    }
  }
}

extension StyleDTO.Size.Height {
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

extension StyleDTO.Size.Height {
  fileprivate var headerHeightMode: MagazineLayoutHeaderHeightMode {
    switch self {
    case .dynamic, .dynamicWithEstimatedHeight, .dynamicAndStretchToTallestItemInRow:
      return .dynamic

    case .static(let height):
      return .static(height: height)
    }
  }
}
