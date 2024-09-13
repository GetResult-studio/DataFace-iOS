// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import Foundation
import UIKit

// MARK: - DFHostViewModel

struct DFHostViewModel: Decodable {
  let screen: Screen
  let sections: [Section]

  init(screen: Screen, sections: [Section]) {
    self.screen = screen
    self.sections = sections
  }

  private enum CodingKeys: String, CodingKey {
    case screen, sections
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    screen = try container.decode(Screen.self, forKey: .screen)
    sections = try container.decode([Section].self, forKey: .sections)
  }
}
