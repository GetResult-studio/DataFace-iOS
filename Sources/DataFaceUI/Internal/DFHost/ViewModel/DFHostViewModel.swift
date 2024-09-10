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
