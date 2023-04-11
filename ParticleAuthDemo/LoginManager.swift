//
//  LoginManager.swift
//  ParticleAuthDemo
//
//  Created by link on 30/03/2023.
//

import Foundation
import ParticleAuthService
import RxSwift
import SafariServices

class LoginManager {
    let bag = DisposeBag()
    static let shared: LoginManager = .init()
    
    var vc: SFSafariViewController?
    
    func login() {
        var projectId = ""
        var clientKey = ""
        var appId = ""
        // read from ParticleNetwork-Info.plist
        if let path = Bundle.main.path(forResource: "ParticleNetwork-Info", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let projectUuid = dict["PROJECT_UUID"] as? String,
           let projectClientKey = dict["PROJECT_CLIENT_KEY"] as? String, let projectAppUuid = dict["PROJECT_APP_UUID"] as? String
        {
            projectId = projectUuid
            clientKey = projectClientKey
            appId = projectAppUuid
        }
        
        let string = "https://web-demo.particle.network/webRedirect?projectId=\(projectId)&clientKey=\(clientKey)&appId=\(appId)"
        
        let url = URL(string: string)!
        
        self.vc = SFSafariViewController(url: url)
        self.vc?.modalPresentationStyle = .formSheet
        UIApplication.shared.windows[0].rootViewController?.present(self.vc!, animated: true)
    }
    
    func canHandle(url: URL) -> Bool {
        guard let urlCom = URLComponents(string: url.absoluteString), let scheme = urlCom.scheme, let host = urlCom.host, let queryItems = urlCom.queryItems else { return false }
        
        guard scheme == "happywallet", host == "callback" else { return false }
        let userInfoItem = queryItems.first {
            $0.name == "userInfo"
        }
        if userInfoItem == nil { return false }
        
        guard let userInfoJsonString = userInfoItem!.value else { return false }
        
        self.vc?.dismiss(animated: true)
        self.vc = nil
        // login locally
        self.setUserInfo(jsonString: userInfoJsonString)
        
        return false
    }

    func setUserInfo(jsonString: String) {
        ParticleAuthService.setUserInfo(json: jsonString)
            .subscribe { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let userInfo):
                    print("login success")
                    print(userInfo)
                case .failure(let error):
                    print("login failed")
                    print(error)
                }
            }.disposed(by: self.bag)
    }
}
