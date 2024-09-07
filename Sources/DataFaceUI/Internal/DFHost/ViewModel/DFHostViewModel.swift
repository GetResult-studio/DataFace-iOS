// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import Foundation

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
  enum Section: Decodable {
    case custom(dataID: AnyHashable, items: [Item])

    private enum CodingKeys: String, CodingKey {
      case id, items
    }

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      let dataID = try container.decode(String.self, forKey: .id)
      let items = try container.decode([Item].self, forKey: .items).filter { $0 != .unknown }

      self = .custom(dataID: dataID, items: items)
    }
  }
}

// MARK: DFHostViewModel.Item

extension DFHostViewModel {
  enum Item: Decodable, Equatable {
    case custom(dataID: AnyHashable, type: String, content: Data, style: Data)
    case unknown

    // MARK: Lifecycle

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      guard let dataID = try container.decodeIfPresent(String.self, forKey: .id), !dataID.isEmpty else {
        self = .unknown
        return
      }

      guard let type = try container.decodeIfPresent(String.self, forKey: .type), !type.isEmpty else {
        self = .unknown
        return
      }

      guard let contentData = try container.decodeNestedContainerAsDataIfPresent(forKey: .content) else {
        self = .unknown
        return
      }

      guard let styleData = try container.decodeNestedContainerAsDataIfPresent(forKey: .style) else {
        self = .unknown
        return
      }

      self = .custom(dataID: dataID, type: type, content: contentData, style: styleData)
    }

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id, type, content, style
    }
  }
}
