// Created by Aleksei Smirnov on 09/08/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Epoxy
import UIKit

// MARK: UICollectionViewDelegate

extension DFHostViewController {

  func collectionView(
    collectionView: UICollectionView,
    targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath,
    toProposedIndexPath proposedIndexPath: IndexPath)
    -> IndexPath
  {
    self.collectionView.collectionView(
      collectionView,
      targetIndexPathForMoveFromItemAt: originalIndexPath,
      toProposedIndexPath: proposedIndexPath)
  }

  func collectionView(
    collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath)
  {
    self.collectionView.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
  }

  func collectionView(
    collectionView: UICollectionView,
    didEndDisplaying cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath)
  {
    self.collectionView.collectionView(
      collectionView,
      didEndDisplaying: cell,
      forItemAt: indexPath)
  }

  func collectionView(
    collectionView: UICollectionView,
    willDisplaySupplementaryView view: UICollectionReusableView,
    forElementKind elementKind: String,
    at indexPath: IndexPath)
  {
    self.collectionView.collectionView(
      collectionView,
      willDisplaySupplementaryView: view,
      forElementKind: elementKind,
      at: indexPath)
  }

  func collectionView(
    collectionView: UICollectionView,
    didEndDisplayingSupplementaryView view: UICollectionReusableView,
    forElementOfKind elementKind: String,
    at indexPath: IndexPath)
  {
    self.collectionView.collectionView(
      collectionView,
      didEndDisplayingSupplementaryView: view,
      forElementOfKind: elementKind,
      at: indexPath)
  }

  func collectionView(
    _: UICollectionView,
    shouldHighlightItemAt indexPath: IndexPath)
    -> Bool
  {
    collectionView.collectionView(collectionView, shouldHighlightItemAt: indexPath)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    didHighlightItemAt indexPath: IndexPath)
  {
    self.collectionView.collectionView(collectionView, didHighlightItemAt: indexPath)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    didUnhighlightItemAt indexPath: IndexPath)
  {
    self.collectionView.collectionView(collectionView, didUnhighlightItemAt: indexPath)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    shouldSelectItemAt indexPath: IndexPath)
    -> Bool
  {
    self.collectionView.collectionView(collectionView, shouldSelectItemAt: indexPath)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath)
  {
    self.collectionView.collectionView(collectionView, didSelectItemAt: indexPath)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    shouldDeselectItemAt indexPath: IndexPath)
    -> Bool
  {
    self.collectionView.collectionView(collectionView, shouldDeselectItemAt: indexPath)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    didDeselectItemAt indexPath: IndexPath)
  {
    self.collectionView.collectionView(collectionView, didDeselectItemAt: indexPath)
  }

  func collectionView(
    collectionView: UICollectionView,
    transitionLayoutForOldLayout fromLayout: UICollectionViewLayout,
    newLayout toLayout: UICollectionViewLayout)
    -> UICollectionViewTransitionLayout
  {
    self.collectionView.collectionView(
      collectionView,
      transitionLayoutForOldLayout: fromLayout,
      newLayout: toLayout)
  }
}
