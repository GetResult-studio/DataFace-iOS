// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCore
import UIKit

// MARK: - CustomLabel

final class CustomLabel: UIView, EpoxyableView {

  // MARK: Lifecycle

  init(style: Style) {
    label = UILabel()
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      label.topAnchor.constraint(equalTo: topAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])

    label.font = style.font
    label.numberOfLines = style.numberOfLines
    if style.showLabelBackground {
      backgroundColor = .secondarySystemBackground
    }
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  // MARK: StyledView

  struct Style: Hashable {
    let font: UIFont
    let showLabelBackground: Bool
    var numberOfLines = 0
  }

  // MARK: ContentConfigurableView

  typealias Content = String

  func setContent(_ content: String, animated _: Bool) {
    label.text = content
  }

  // MARK: Private

  private let label: UILabel

}

extension CustomLabel.Style {
  static func style(
    with textStyle: UIFont.TextStyle,
    showBackground: Bool = false)
    -> CustomLabel.Style
  {
    .init(
      font: UIFont.preferredFont(forTextStyle: textStyle),
      showLabelBackground: showBackground)
  }
}

extension CustomLabel {
  struct ContentDTO: Decodable {
    let text: String
  }

  struct StyleDTO: Decodable {
    let numberOfLines: Int
  }

  static func decodeContent(data: Data) -> Content? {
    let content = try? JSONDecoder().decode(ContentDTO.self, from: data)
    return content?.text
  }

  static func decodeStyle(data: Data) -> Style? {
    guard let style = try? JSONDecoder().decode(StyleDTO.self, from: data) else {
      return nil
    }

    return .init(
      font: UIFont.preferredFont(forTextStyle: .body),
      showLabelBackground: true,
      numberOfLines: style.numberOfLines)
  }
}
