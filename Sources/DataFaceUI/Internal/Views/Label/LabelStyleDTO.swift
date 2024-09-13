// Created by Aleksei Smirnov on 09/13/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import SwiftUI

// MARK: - LabelStyleDTO

struct LabelStyleDTO: Decodable {
  let insets: UIEdgeInsetsDTO?
  let textColor: String?
  let alignment: String?
  let textAlignment: String?
}

extension LabelStyleDTO {
  var uiStyle: Label.Style {
    let insets = insets?.swiftUIEdgeInsets ?? .init()
    let textColor = Color(uiColor: textColor.uiColor ?? .label)
    let alignment = LabelAlignmentDTO(rawValue: alignment ?? "")?.uiAlignmnet ?? .topLeading
    let textAlignment = LabelTextAlignmentDTO(rawValue: textAlignment ?? "")?.uiAlignmnet ?? .leading
    return .init(
      insets: insets,
      alignment: alignment,
      textColor: textColor,
      textAlignment: textAlignment)
  }
}
