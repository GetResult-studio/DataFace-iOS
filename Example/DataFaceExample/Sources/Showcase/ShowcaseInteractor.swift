// Created by Aleksei Smirnov on 09/20/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import DataFaceUI
import Foundation

// MARK: - ShowcaseInteractor

final class ShowcaseInteractor {
  weak var inputDelegate: DFDFHostInputDelegate?
}

// MARK: DFHostOutputDelegete

extension ShowcaseInteractor: DFHostOutputDelegete {
  func viewDidLoad() {
    print("viewDidLoad")
  }

  func startLoadingData() {
    print("startLoadingData")
  }

  func didRequestToPerformAction(
    sectionDataID: AnyHashable,
    itemDataID _: AnyHashable,
    _ action: Action)
  {
    if action.url.absoluteString == "inAppShema://performAction" {
      print("didRequestToPerformAction", "inAppShema://performAction")
    }

    if action.url.absoluteString == "inAppShema://update" {
      DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        let changes: Change<DFHostViewModel.Item> = {
          let url = Bundle.main.url(forResource: "ShowcaseUpdate", withExtension: "json")!
          let data = try! Data(contentsOf: url)
          return try! JSONDecoder().decode(Change<DFHostViewModel.Item>.self, from: data)
        }()

        self.inputDelegate?.applyChanges(in: sectionDataID, with: changes)
      }
    }
  }
}

// MARK: CustomItemsFactoryDelegate

extension ShowcaseInteractor: CustomItemsFactoryDelegate {
  func didSelectLabel(dataID: AnyHashable) {
    print("didSelectLabel(dataID:)", dataID)
  }
}
