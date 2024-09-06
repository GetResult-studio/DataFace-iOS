// Created by Aleksei Smirnov on 09/05/24.
// Copyright © 2024 GetResult.studio. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo _: UISceneSession,
    options _: UIScene.ConnectionOptions)
  {
    guard let windowScence = scene as? UIWindowScene else { return }
    let window = UIWindow(windowScene: windowScence)
    self.window = window
    let controller = UIViewController()
    controller.view.backgroundColor = .red
    window.rootViewController = controller
    window.makeKeyAndVisible()
  }
}
