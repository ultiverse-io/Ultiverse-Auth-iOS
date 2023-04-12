//
//  AppDelegate.swift
//  ParticleAuthDemo
//
//  Created by link on 2022/11/3.
//

import ParticleAuthService
import ParticleNetworkBase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initialize Particle Network
        ParticleNetwork.initialize(config: .init(chainInfo: .ethereum(.mainnet), devEnv: .debug))

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if LoginManager.shared.canHandle(url: url) {
            return true
        } else {
            return ParticleAuthService.handleUrl(url)
        }
    }
}
