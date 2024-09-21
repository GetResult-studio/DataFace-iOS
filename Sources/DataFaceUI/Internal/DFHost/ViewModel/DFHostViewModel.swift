// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import Foundation
import UIKit

// MARK: - DFHostViewModel

public final class DFHostViewModel: Decodable {

  // MARK: Lifecycle

  init(screen: Screen = .init(), sections: [Section] = []) {
    self.screen = screen
    self.sections = sections
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    screen = try container.decode(Screen.self, forKey: .screen)
    sections = try container.decode([Section].self, forKey: .sections)
  }

  // MARK: Internal

  let screen: Screen
  private(set) var sections: [Section]

  // MARK: Private

  private enum CodingKeys: String, CodingKey {
    case screen, sections
  }
}

extension DFHostViewModel {
  func updateItems(in sectionDataID: AnyHashable, changes: Change<Item>) {
    if let index = sections.firstIndex(where: { $0.dataID == sectionDataID }) {
      sections[index].applyContent(changes: changes)
    }
  }
}
