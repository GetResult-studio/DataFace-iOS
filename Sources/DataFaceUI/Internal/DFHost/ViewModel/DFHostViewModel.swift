// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import Foundation
import UIKit

// MARK: - DFHostViewModel

final class DFHostViewModel: Decodable {

  // MARK: Lifecycle

  init(screen: Screen = .init(), sections: [Section] = []) {
    self.screen = screen
    self.sections = sections
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    screen = try container.decode(Screen.self, forKey: .screen)
    sections = try container.decode([Section].self, forKey: .sections)
  }

  // MARK: Internal

  let screen: Screen
  let sections: [Section]

  // MARK: Private

  private enum CodingKeys: String, CodingKey {
    case screen, sections
  }

}
