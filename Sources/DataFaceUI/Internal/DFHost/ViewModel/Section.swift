// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import Foundation

// MARK: - DFHostViewModel.Section

extension DFHostViewModel {
  struct Section: Decodable {

    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      dataID = try container.decode(String.self, forKey: .dataID)
      style = try container.decode(Style.self, forKey: .style)
      content = try container.decode([Item].self, forKey: .content)
      header = try container.decodeIfPresent(HeaderFooter.self, forKey: .header)
      footer = try container.decodeIfPresent(HeaderFooter.self, forKey: .footer)
      background = try container.decodeIfPresent(Background.self, forKey: .background)
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

    struct HeaderFooter: Decodable {
      let style: HeaderFooterStyleDTO
      let content: Item

      private enum CodingKeys: CodingKey {
        case style
        case content
      }

      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        style = try container.decode(HeaderFooterStyleDTO.self, forKey: .style)
        content = try container.decode(Item.self, forKey: .content)
      }
    }

    struct Background: Decodable {
      let content: Item

      private enum CodingKeys: CodingKey {
        case dataID
        case content
      }

      init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content = try container.decode(Item.self, forKey: .content)
      }
    }

    let dataID: AnyHashable
    let style: Style
    private(set) var content: [Item]
    let header: HeaderFooter?
    let footer: HeaderFooter?
    let background: Background?

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case dataID
      case style
      case content
      case header
      case footer
      case background
    }
  }
}

extension DFHostViewModel.Section {
  mutating func applyContent(changes: Change<DFHostViewModel.Item>) {
    content = content.applying(changes)
  }
}
