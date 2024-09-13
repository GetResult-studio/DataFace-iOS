// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import Foundation

// MARK: DFHostViewModel.Item

extension DFHostViewModel {
  struct Item: Decodable {

    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      dataID = try container.decode(String.self, forKey: .dataID)
      style = try container.decode(StyleDTO.self, forKey: .style)

      switch style.type {
      case .label:
        let data = try container.decode(String.self, forKey: .content)
        content = .label(data: data)

      case .dummyView:
        let data = try container.decode(DummyViewContentDTO.self, forKey: .content)
        content = .dummyView(data: data)

      default:
        let contentData = try container.decodeNestedContainerAsDataIfPresent(forKey: .content)
        content = .custom(data: contentData)
      }
    }

    // MARK: Internal

    enum Content: Decodable {
      case label(data: String)
      case dummyView(data: DummyViewContentDTO)
      case custom(data: Data?)
    }

    let dataID: AnyHashable
    let style: StyleDTO
    let content: Content

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case dataID, type, content, style
    }
  }
}
