//
//  AppDelegate.swift
//  ListControllerExample
//
//  Created by Dmitry Zakharov on 06.08.2021.
//

import UIKit

// MARK: - AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public properties

    var window: UIWindow?

    // MARK: - Public methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = UINavigationController(rootViewController: ExamplesViewController())

        window?.rootViewController = controller
        window?.makeKeyAndVisible()

        return true
    }
}
