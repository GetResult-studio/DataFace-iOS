// Created by Aleksei Smirnov on 09/08/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import SwiftUI
import UIKit

public struct UIEdgeInsetsDTO: Decodable {

  // MARK: Lifecycle

  public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
    self.top = top
    self.left = left
    self.bottom = bottom
    self.right = right
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let top = try container.decodeIfPresent(CGFloat.self, forKey: .top) ?? 0
    let left = try container.decodeIfPresent(CGFloat.self, forKey: .left) ?? 0
    let bottom = try container.decodeIfPresent(CGFloat.self, forKey: .bottom) ?? 0
    let right = try container.decodeIfPresent(CGFloat.self, forKey: .right) ?? 0

    self.init(top: top, left: left, bottom: bottom, right: right)
  }

  // MARK: Public

  public let top: CGFloat
  public let left: CGFloat
  public let bottom: CGFloat
  public let right: CGFloat

  public var uiEdgeInsets: UIEdgeInsets {
    .init(top: top, left: left, bottom: bottom, right: right)
  }

  public var swiftUIEdgeInsets: EdgeInsets {
    .init(top: top, leading: left, bottom: bottom, trailing: right)
  }

  // MARK: Private

  private enum CodingKeys: String, CodingKey {
    case top, left, bottom, right
  }
}
