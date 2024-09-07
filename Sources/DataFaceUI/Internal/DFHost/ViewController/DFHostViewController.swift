// Created by Aleksei Smirnov on 09/05/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import EpoxyCore
import UIKit

// MARK: - DFHostViewController

final class DFHostViewController: CollectionViewController {

  // MARK: Lifecycle

  init() {
    super.init(layout: UICollectionViewFlowLayout())
  }

  // MARK: Internal

  var listItemsFactory: ListItemsFactoryProtocol?
  var interactor: DFHostInteractorProtocol?

  override func viewDidLoad() {
    super.viewDidLoad()
    interactor?.viewDidLoad()
  }

  override func makeCollectionView() -> CollectionView {
    let collectionView = super.makeCollectionView()
    collectionView.delaysContentTouches = false
    return collectionView
  }

  // MARK: Private

  private var viewModel: DFHostViewModel = .init(sections: [])

  @SectionModelBuilder
  private var sections: [SectionModel] {
    viewModel.sections.compactMap { section in
      switch section {
      case .custom(let dataID, let items):
        SectionModel(dataID: dataID) {
          items.compactMap { item in
            switch item {
            case .custom(let dataID, let type, let content, let style):
              EpoxyLogger.shared.assert(
                listItemsFactory != nil, "Custom doesn't work without listItemsFactory")
              return listItemsFactory?.makeItem(
                collectionViewSize: view.frame.size,
                dataID: dataID,
                type: type,
                content: content,
                style: style)

            case .unknown:
              return nil
            }
          }
        }
      }
    }
  }
}

// MARK: DFHostViewControllerProtocol

extension DFHostViewController: DFHostViewControllerProtocol {
  func updateUI(viewModel: DFHostViewModel) {
    self.viewModel = viewModel
    collectionView.setSections(sections, animated: true)
  }
}
