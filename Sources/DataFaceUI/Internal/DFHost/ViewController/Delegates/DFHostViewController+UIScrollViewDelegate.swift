// Created by Aleksei Smirnov on 09/08/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import UIKit

// MARK: UIScrollViewDelegate

extension DFHostViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    collectionView.scrollViewDidScroll(scrollView)
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    collectionView.scrollViewWillBeginDragging(scrollView)
  }

  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>)
  {
    collectionView.scrollViewWillEndDragging(
      scrollView,
      withVelocity: velocity,
      targetContentOffset: targetContentOffset)
  }

  func scrollViewDidEndDragging(
    _ scrollView: UIScrollView,
    willDecelerate decelerate: Bool)
  {
    collectionView.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
  }

  func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
    collectionView.scrollViewShouldScrollToTop(scrollView)
  }

  func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    collectionView.scrollViewDidScrollToTop(scrollView)
  }

  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    collectionView.scrollViewWillBeginDecelerating(scrollView)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    collectionView.scrollViewDidEndDecelerating(scrollView)
  }

  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    collectionView.scrollViewDidEndScrollingAnimation(scrollView)
  }
}
