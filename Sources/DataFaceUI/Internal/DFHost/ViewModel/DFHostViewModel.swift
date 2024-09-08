// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import Foundation
import UIKit

// MARK: - DFHostViewModel

struct DFHostViewModel: Decodable {
  let sections: [Section]

  init(sections: [Section]) {
    self.sections = sections
  }

  private enum CodingKeys: String, CodingKey {
    case sections
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    sections = try container.decode([Section].self, forKey: .sections)
  }
}

// MARK: DFHostViewModel.Section

extension DFHostViewModel {
  struct Section: Decodable {

    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      dataID = try container.decode(String.self, forKey: .dataID)
      style = try container.decode(Style.self, forKey: .style)
      content = try container.decode([Item].self, forKey: .content)
    }

    // MARK: Internal

    struct Style: Decodable {
      let hSpacing: CGFloat?
      let vSpacing: CGFloat?
      let insets: UIEdgeInsetsDTO?
      let itemsInsets: UIEdgeInsetsDTO?

      private enum CodingKeys: String, CodingKey {
        case hSpacing
        case vSpacing
        case insets
        case itemsInsets
      }

      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hSpacing = try container.decodeIfPresent(CGFloat.self, forKey: .hSpacing)
        vSpacing = try container.decodeIfPresent(CGFloat.self, forKey: .vSpacing)
        insets = try container.decodeIfPresent(UIEdgeInsetsDTO.self, forKey: .insets)
        itemsInsets = try container.decodeIfPresent(UIEdgeInsetsDTO.self, forKey: .itemsInsets)
      }
    }

    let dataID: AnyHashable
    let style: Style
    let content: [Item]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case dataID
      case style
      case content
    }

  }
}

// MARK: DFHostViewModel.Item

extension DFHostViewModel {
  struct Item: Decodable {

    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      dataID = try container.decode(String.self, forKey: .dataID)
      style = try container.decode(Style.self, forKey: .style)

      switch style.type {
      default:
        let contentData = try container.decodeNestedContainerAsDataIfPresent(forKey: .content)
        content = .custom(data: contentData)
      }
    }

    // MARK: Internal

    struct Style: Decodable {

      // MARK: Lifecycle

      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let type = try container.decode(String.self, forKey: .type)
        switch type {
        default:
          let data = try container.decodeNestedContainerAsDataIfPresent(forKey: .data)
          self.type = .custom(name: type, data: data)
        }

        size = try container.decode(Size.self, forKey: .size)
      }

      // MARK: Internal

      struct Size: Decodable {
        enum Width: Decodable {
          case fullWidth(respectsHorizontalInsets: Bool)
          case fractional(divisor: UInt)

          // MARK: Lifecycle

          init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(Kind.self, forKey: .type)

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

          enum Kind: String, Decodable {
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
            let type = try container.decode(Kind.self, forKey: .type)

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

          enum Kind: String, Decodable {
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

      enum Kind: Decodable {
        case custom(name: String, data: Data?)
      }

      let type: Kind
      let size: Size

      // MARK: Private

      private enum CodingKeys: String, CodingKey {
        case type, size, data
      }
    }

    enum Content: Decodable {
      case custom(data: Data?)
    }

    let dataID: AnyHashable
    let style: Style
    let content: Content

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case dataID, type, content, style
    }
  }
}
