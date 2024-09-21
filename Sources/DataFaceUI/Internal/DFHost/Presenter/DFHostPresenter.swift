// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import Epoxy
import Foundation

// MARK: - DFHostPresenter

final class DFHostPresenter {

  // MARK: Lifecycle

  init(viewController: DFHostViewControllerProtocol?) {
    self.viewController = viewController
  }

  // MARK: Internal

  weak var viewController: DFHostViewControllerProtocol?

  // MARK: Private

  private var viewModel: DFHostViewModel?

  private func mapJSONToViewModel(_ json: String) -> DFHostViewModel? {
    guard let data = json.data(using: .utf8) else {
      EpoxyLogger.shared.assertionFailure("It seems json is empty")
      return nil
    }
    return try? JSONDecoder().decode(DFHostViewModel.self, from: data)
  }
}

// MARK: DFHostPresenterProtocol

extension DFHostPresenter: DFHostPresenterProtocol {
  func didRecieveStaticJSON(_ json: String) {
    guard let viewModel = mapJSONToViewModel(json) else {
      EpoxyLogger.shared.assertionFailure("Decoding failed")
      return // TODO: - Status View
    }
    self.viewModel = viewModel
    viewController?.updateUI(viewModel: viewModel)
  }

  func applyChanges(sectionDataID: AnyHashable, changes: Change<DFHostViewModel.Item>) {
    viewModel?.updateItems(in: sectionDataID, changes: changes)
    guard let viewModel else { return }
    viewController?.updateUI(viewModel: viewModel)
  }
}
