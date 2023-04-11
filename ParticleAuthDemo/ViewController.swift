//
//  ViewController.swift
//  ParticleAuthDemo
//
//  Created by link on 2022/11/3.
//

import UIKit
import ParticleAuthService

class ViewController: UIViewController {
    @IBOutlet var LoginButton: UIButton!
    
    @IBOutlet var publicAddressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func LoginClick(_ sender: UIButton) {
        LoginManager.shared.login(success: { [weak self] userInfo in
            guard let self = self else { return }
            // get user info
            self.publicAddressLabel.text = ParticleAuthService.getAddress()
        }, failure: { error in
            print(error)
        })
    }
}
