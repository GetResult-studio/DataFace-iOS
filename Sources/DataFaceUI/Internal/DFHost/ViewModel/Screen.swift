// Created by Aleksei Smirnov on 09/13/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView

// MARK: - DFHostViewModel.Screen

extension DFHostViewModel {
  struct Screen: Decodable {

    // MARK: Lifecycle

    init(selectionStyle: SelectionStyle = .noBackground) {
      self.selectionStyle = selectionStyle
    }

    init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      let selectionStyle = try container.decodeIfPresent(String.self, forKey: .selectionStyle)
      self.selectionStyle = SelectionStyle(selectionStyle)
    }

    // MARK: Internal

    enum SelectionStyle {
      case noBackground
      case color(String?)

      init(_ string: String?) {
        if let string, string != "noBackground" {
          self = .color(string)
        } else {
          self = .noBackground
        }
      }
    }

    let selectionStyle: SelectionStyle

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case selectionStyle
    }
  }
}

extension DFHostViewModel.Screen.SelectionStyle {
  var uiSelectionStyle: ItemSelectionStyle {
    switch self {
    case .noBackground:
      return .noBackground
    case .color(let string):
      guard let color = string.uiColor else { return .noBackground }
      return .color(color)
    }
  }
}
