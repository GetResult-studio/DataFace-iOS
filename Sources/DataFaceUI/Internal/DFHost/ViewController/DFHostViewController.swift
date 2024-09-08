// Created by Aleksei Smirnov on 09/05/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import EpoxyCore
import MagazineLayout
import UIKit

// MARK: - DFHostViewController

final class DFHostViewController: CollectionViewController {

  // MARK: Lifecycle

  init() {
    super.init(layout: MagazineLayout())
  }

  // MARK: Internal

  var listItemsFactory: ListItemsFactoryProtocol?
  var interactor: DFHostInteractorProtocol?
  private(set) var viewModel: DFHostViewModel = .init(sections: [])

  override func viewDidLoad() {
    super.viewDidLoad()
    interactor?.viewDidLoad()
  }

  override func makeCollectionView() -> CollectionView {
    let collectionView = super.makeCollectionView()
    collectionView.contentInsetAdjustmentBehavior = .always
    collectionView.delaysContentTouches = false
    collectionView.delegate = self
    return collectionView
  }

  // MARK: Private

  @SectionModelBuilder
  private var sections: [SectionModel] {
    viewModel.sections.compactMap { section in
      SectionModel(dataID: section.dataID) {
        section.content.compactMap { item in
          switch item.style.type {
          case .custom(let name, let styleData):
            EpoxyLogger.shared.assert(
              listItemsFactory != nil, "Custom doesn't work without listItemsFactory")
            let content = {
              if case .custom(let val) = item.content { return val } else { return nil }
            }()
            guard let content, let styleData, !name.isEmpty else { return nil }
            return listItemsFactory?.makeItem(
              dataID: item.dataID,
              type: name,
              content: content,
              style: styleData)
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
