// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCore
import UIKit

final class DummyView: UIView, EpoxyableView {

  // MARK: Lifecycle

  init(style: Style) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    isUserInteractionEnabled = false

    if let insets = style.insets {
      directionalLayoutMargins = .init(
        top: insets.top,
        leading: insets.left,
        bottom: insets.bottom,
        trailing: insets.right)
    }

    addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      view.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      view.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      view.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
    ])

    if let cornerRadius = style.cornerRadius {
      view.layer.cornerRadius = cornerRadius
    }
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  struct Style: Hashable {
    let insets: UIEdgeInsets?
    let cornerRadius: CGFloat?

    init(insets: UIEdgeInsets? = .zero, cornerRadius: CGFloat? = nil) {
      self.insets = insets
      self.cornerRadius = cornerRadius
    }
  }

  struct Content: Equatable {
    let backgroundColor: UIColor

    init(backgroundColor: UIColor? = .clear) {
      self.backgroundColor = backgroundColor ?? .clear
    }
  }

  func setContent(_ content: Content, animated _: Bool) {
    view.backgroundColor = content.backgroundColor
  }

  // MARK: Private

  private let view = UIView()

}
