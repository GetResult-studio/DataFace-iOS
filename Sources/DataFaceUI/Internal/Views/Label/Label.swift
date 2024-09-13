// Created by Aleksei Smirnov on 09/13/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import SwiftUI

struct Label: View {

  // MARK: Lifecycle

  init(content: String, style: Style) {
    self.content = content
    self.style = style
  }

  // MARK: Internal

  struct Style {
    let insets: EdgeInsets
    let textColor: Color
    let alignment: Alignment
    let textAlignment: TextAlignment

    init(
      insets: EdgeInsets,
      alignment: Alignment,
      textColor: Color,
      textAlignment: TextAlignment)
    {
      self.insets = insets
      self.alignment = alignment
      self.textColor = textColor
      self.textAlignment = textAlignment
    }
  }

  let content: String
  let style: Style

  var body: some View {
    Text(content)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: style.alignment)
      .multilineTextAlignment(style.textAlignment)
      .foregroundColor(style.textColor)
      .padding(style.insets)
  }
}
