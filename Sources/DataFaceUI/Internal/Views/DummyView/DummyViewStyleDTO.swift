// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Foundation

// MARK: - DummyViewStyleDTO

struct DummyViewStyleDTO: Decodable {
  let insets: UIEdgeInsetsDTO?
  let cornerRadius: CGFloat?
}

extension DummyViewStyleDTO {
  var uiStyle: DummyView.Style {
    .init(
      insets: insets?.uiEdgeInsets,
      cornerRadius: cornerRadius)
  }
}
