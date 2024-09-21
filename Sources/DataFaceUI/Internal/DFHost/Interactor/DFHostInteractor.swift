// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceCore
import UIKit

// MARK: - DFHostInteractor

final class DFHostInteractor {

  // MARK: Lifecycle

  init(
    input: DFHostInput,
    router: DFHostRouterProtocol,
    presenter: DFHostPresenterProtocol)
  {
    self.input = input
    self.router = router
    self.presenter = presenter
  }

  // MARK: Internal

  var output: DFHostOutputDelegete?

  // MARK: Private

  private let input: DFHostInput
  private let router: DFHostRouterProtocol
  private let presenter: DFHostPresenterProtocol

  private func perform(sectionDataID: AnyHashable, itemDataID: AnyHashable, action: Action) {
    switch action.url.scheme {
    case "https":
      OpenLinkInBrowserService.shared.openLink(url: action.url)

    default:
      output?.didRequestToPerformAction(sectionDataID: sectionDataID, itemDataID: itemDataID, action)
    }
  }
}

// MARK: DFHostInteractorProtocol

extension DFHostInteractor: DFHostInteractorProtocol {
  func viewDidLoad() {
    output?.viewDidLoad()

    switch input.content.mode {
    case .backendDrivenUI(let url): // TODO: - fetch
      output?.startLoadingData()

    case .static(let json):
      presenter.didRecieveStaticJSON(json)
    }
  }

  func performActionsIfPossible(
    sectionDataID: AnyHashable,
    itemDataID: AnyHashable,
    _ actions: [Action])
  {
    for action in actions {
      perform(sectionDataID: sectionDataID, itemDataID: itemDataID, action: action)
    }
  }
}

// MARK: DFDFHostInputDelegate

extension DFHostInteractor: DFDFHostInputDelegate {
  func applyChanges(in sectionDataID: AnyHashable, with changes: Change<DFHostViewModel.Item>) {
    presenter.applyChanges(sectionDataID: sectionDataID, changes: changes)
  }
}
