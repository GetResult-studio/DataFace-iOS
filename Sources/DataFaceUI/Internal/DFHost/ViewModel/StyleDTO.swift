// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Foundation

// MARK: - StyleData

enum StyleData: Decodable {
  case dummyView(style: DummyViewStyleDTO)
  case custom(name: String, data: Data?)
}

// MARK: - StyleDTO

struct StyleDTO: Decodable {

  // MARK: Lifecycle

  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(String.self, forKey: .type)
    switch type {
    case "dummy":
      let data = try container.decode(DummyViewStyleDTO.self, forKey: .data)
      self.type = .dummyView(style: data)

    default:
      let data = try container.decodeNestedContainerAsDataIfPresent(forKey: .data)
      self.type = .custom(name: type, data: data)
    }

    size = try container.decodeIfPresent(Size.self, forKey: .size)
  }

  // MARK: Internal

  struct Size: Decodable {
    enum Width: Decodable {
      case fullWidth(respectsHorizontalInsets: Bool)
      case fractional(divisor: UInt)

      // MARK: Lifecycle

      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Type.self, forKey: .type)

        switch type {
        case .fullWidth:
          let respectsHorizontalInsets = try container.decodeIfPresent(Bool.self, forKey: .respectsHorizontalInsets) ?? true
          self = .fullWidth(respectsHorizontalInsets: respectsHorizontalInsets)

        case .fractional:
          let divisor = try container.decodeIfPresent(UInt.self, forKey: .divisor) ?? 1
          self = .fractional(divisor: divisor)
        }
      }

      // MARK: Internal

      enum `Type`: String, Decodable {
        case fullWidth, fractional
      }

      // MARK: Private

      private enum CodingKeys: String, CodingKey {
        case type, respectsHorizontalInsets, divisor
      }
    }

    enum Height: Decodable {
      case dynamic
      case dynamicWithEstimatedHeight(estimatedHeight: CGFloat)
      case dynamicAndStretchToTallestItemInRow
      case `static`(height: CGFloat)

      // MARK: Lifecycle

      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(`Type`.self, forKey: .type)

        switch type {
        case .dynamic:
          if let estimatedHeight = try container.decodeIfPresent(CGFloat.self, forKey: .estimatedHeight) {
            self = .dynamicWithEstimatedHeight(estimatedHeight: estimatedHeight)
          } else {
            self = .dynamic
          }

        case .dynamicAndStretchToTallestItemInRow:
          self = .dynamicAndStretchToTallestItemInRow

        case .static:
          let height = try container.decode(CGFloat.self, forKey: .height)
          self = .static(height: height)
        }
      }

      // MARK: Internal

      enum `Type`: String, Decodable {
        case dynamic, dynamicAndStretchToTallestItemInRow, `static`
      }

      // MARK: Private

      private enum CodingKeys: String, CodingKey {
        case type, estimatedHeight, height
      }
    }

    let width: Width
    let height: Height
  }

  enum `Type`: Decodable {
    case dummyView(style: DummyViewStyleDTO)
    case custom(name: String, data: Data?)
  }

  let type: `Type`
  let size: Size?

  // MARK: Private

  private enum CodingKeys: String, CodingKey {
    case type, size, data
  }
}
