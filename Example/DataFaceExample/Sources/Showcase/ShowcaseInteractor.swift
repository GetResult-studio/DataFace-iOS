// Created by Aleksei Smirnov on 09/20/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceUI

// MARK: - ShowcaseInteractor

final class ShowcaseInteractor { }

// MARK: DFHostOutputDelegete

extension ShowcaseInteractor: DFHostOutputDelegete {
  func viewDidLoad() {
    print("viewDidLoad")
  }

  func startLoadingData() {
    print("startLoadingData")
  }

  func didRequestToPerformAction(_ action: Action) {
    if action.url.absoluteString == "inAppShema://performAction" {
      print("didRequestToPerformAction", "inAppShema://performAction")
    }
  }
}

// MARK: CustomItemsFactoryDelegate

extension ShowcaseInteractor: CustomItemsFactoryDelegate {
  func didSelectLabel(dataID: AnyHashable) {
    print("didSelectLabel(dataID:)", dataID)
  }
}
