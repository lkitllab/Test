//
//  AppContainer.swift
//  SwiftTestQuest
//
//  Created by Kit on 3/22/21.
//

import UIKit
import Moya
import Alamofire

class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 3
        configuration.timeoutIntervalForResource = 3
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}

final class AppContainer {
    
    static func sigInViewController() -> SignInViewController {
        let provider = MoyaProvider<SignInService>(session: DefaultAlamofireSession.shared, plugins: [])
        let model = SignInViewModel(provider: provider)
        let controller = SignInViewController()
        controller.model = model
        return controller
    }
    
    static func startViewController() -> StartViewController {
        StartViewController()
    }
}
