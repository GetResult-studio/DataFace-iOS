// Created by Aleksei Smirnov on 09/06/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import DataFaceUI
import Epoxy
import UIKit

// MARK: - TabbarController

final class TabbarController: UITabBarController {

  // MARK: Internal

  override func viewDidLoad() {
    super.viewDidLoad()

    showcaseViewController.tabBarItem = .init(
      title: "Showcase",
      image: UIImage(systemName: "cart.fill"),
      tag: 0)
    viewControllers = [showcaseViewController]
  }

  // MARK: Private

  private lazy var listItemsFactory = ListItemsFactory()

  private lazy var json: String = {
    let url = Bundle.main.url(forResource: "Showcase", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    return String(data: data, encoding: .utf8)!
  }()

  private lazy var showcaseViewController = DFHostBuilder(
    listItemsFactory: listItemsFactory).build(
    with: .init(content: .init(mode: .static(json: json))),
    output: self)
}

// MARK: DFHostOutputDelegete

extension TabbarController: DFHostOutputDelegete { }
