// Created by Aleksei Smirnov on 09/21/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import EpoxyCore
import UIKit

// MARK: - SpinnerView

public final class SpinnerView: UIView, EpoxyableView, Loadable {

  // MARK: Lifecycle

  override public init(frame: CGRect) {
    super.init(frame: frame)
    addLoader()
    startLoadingAnimation()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) { fatalError() }

  // MARK: Public

  public private(set) var loadingIndicator = ActivityIndicatorView()
}

// MARK: DisplayRespondingView

extension SpinnerView: DisplayRespondingView {
  public func didDisplay(_ isDisplayed: Bool) {
    if isDisplayed {
      startLoadingAnimation()
    }
  }
}
