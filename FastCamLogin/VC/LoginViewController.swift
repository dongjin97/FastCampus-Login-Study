//
//  LoginViewController.swift
//  FastCamLogin
//
//  Created by 원동진 on 2022/11/03.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        [emailLoginButton,googleLoginButton,appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
  
    }
    override func viewWillAppear(_ animated: Bool) {
        //네비게이션 bar 숨기기
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func appleLoginButotnTapped(_ sender: UIButton) {
    }
    
}
