// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

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

  // MARK: Private

  private let input: DFHostInput
  private let router: DFHostRouterProtocol
  private let presenter: DFHostPresenterProtocol

}

// MARK: DFHostInteractorProtocol

extension DFHostInteractor: DFHostInteractorProtocol {
  func viewDidLoad() {
    switch input.content.mode {
    case .backendDrivenUI(let url):
      break // TODO: - fetch
    case .static(let json):
      presenter.didRecieveStaticJSON(json)
    }
  }
}
