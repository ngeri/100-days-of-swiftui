//
//  SceneDelegate.swift
//  FaceMeetup
//
//  Created by Gergely Németh on 2019. 12. 09..
//  Copyright © 2019. Gergely Németh. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let peopleListView = PeopleListView(viewModel: PeopleListViewModel(dataService: CoreDataService.shared))
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: peopleListView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataService.shared.saveContext()
    }
}
