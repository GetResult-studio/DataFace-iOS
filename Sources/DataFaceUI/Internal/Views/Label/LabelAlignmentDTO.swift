// Created by Aleksei Smirnov on 09/13/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import SwiftUI

// MARK: - LabelTextAlignmentDTO

public enum LabelTextAlignmentDTO: String, Decodable {
  case leading
  case center
  case trailing
}

extension LabelTextAlignmentDTO {
  var uiAlignmnet: TextAlignment {
    switch self {
    case .leading: return .leading
    case .center: return .center
    case .trailing: return .trailing
    }
  }
}

// MARK: - LabelAlignmentDTO

public enum LabelAlignmentDTO: String, Decodable {
  case topLeading
  case top
  case topTrailing
  case leading
  case center
  case trailing
  case bottomLeading
  case bottom
  case bottomTrailing
  case leadingLastTextBaseline
  case trailingFirstTextBaseline
}

extension LabelAlignmentDTO {
  var uiAlignmnet: Alignment {
    switch self {
    case .topLeading:
      return .topLeading
    case .top:
      return .top
    case .topTrailing:
      return .topTrailing
    case .leading:
      return .leading
    case .center:
      return .center
    case .trailing:
      return .trailing
    case .bottomLeading:
      return .bottomLeading
    case .bottom:
      return .bottom
    case .bottomTrailing:
      return .bottomTrailing
    case .trailingFirstTextBaseline:
      return .trailingFirstTextBaseline
    case .leadingLastTextBaseline:
      return .leadingLastTextBaseline
    }
  }
}
