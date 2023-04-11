//
//  ViewController.swift
//  ParticleAuthDemo
//
//  Created by link on 2022/11/3.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func LoginClick(_ sender: UIButton) {
        LoginManager.shared.login()
    }
}
