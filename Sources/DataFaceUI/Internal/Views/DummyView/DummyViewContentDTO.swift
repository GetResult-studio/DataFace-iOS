// Created by Aleksei Smirnov on 09/10/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

// MARK: - DummyViewContentDTO

struct DummyViewContentDTO: Decodable {
  let backgroundColor: String?
}

extension DummyViewContentDTO {
  var uiContent: DummyView.Content {
    .init(backgroundColor: backgroundColor.uiColor)
  }
}
