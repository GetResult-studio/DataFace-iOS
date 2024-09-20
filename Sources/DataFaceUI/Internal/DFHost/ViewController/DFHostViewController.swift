// Created by Aleksei Smirnov on 09/05/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import EpoxyCollectionView
import EpoxyCore
import MagazineLayout
import UIKit

// MARK: - DFHostViewController

final class DFHostViewController: CollectionViewController {

  // MARK: Lifecycle

  init(viewFactory: DFHostViewFactoryProtocol) {
    self.viewFactory = viewFactory
    super.init(layout: MagazineLayout())
  }

  // MARK: Internal

  var interactor: DFHostInteractorProtocol?

  private(set) var viewModel: DFHostViewModel = .init(screen: .init(), sections: []) {
    didSet {
      collectionView.backgroundColor = viewModel.screen.backgroundColor.uiColor
      collectionView.selectionStyle = viewModel.screen.selectionStyle.uiSelectionStyle
    }
  }

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

  private let viewFactory: DFHostViewFactoryProtocol

  @SectionModelBuilder
  private var sections: [SectionModel] {
    viewModel.sections.compactMap { section in
      SectionModel(dataID: section.dataID) {
        section.content.compactMap { item in
          viewFactory.makeItem(from: item)?.eraseToAnyItemModel()
            .didSelect { [weak self] _ in
              self?.interactor?.performActionsIfPossible(
                item.actions.filter { $0.type == .didSelect })
            }
        }
      }
      .supplementaryItems(
        ofKind: MagazineLayout.SupplementaryViewKind.sectionHeader,
        viewFactory.makeSupplementaryViewHeaderFooter(from: section.header))
      .supplementaryItems(
        ofKind: MagazineLayout.SupplementaryViewKind.sectionFooter,
        viewFactory.makeSupplementaryViewHeaderFooter(from: section.footer))
      .supplementaryItems(
        ofKind: MagazineLayout.SupplementaryViewKind.sectionBackground,
        viewFactory.makeSupplementaryViewBackground(from: section.background))
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
