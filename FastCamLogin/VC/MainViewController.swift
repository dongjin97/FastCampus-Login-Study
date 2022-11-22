//
//  MainViewController.swift
//  FastCamLogin
//
//  Created by 원동진 on 2022/11/03.
//

import UIKit
import FirebaseAuth
class MainViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        //POP 제스처 막는 코드
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
    }

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do{
            try firebaseAuth.signOut()
            //버튼 눌렀을때 첫번째화면으로 넘어감
            self.navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError {
            print("ERROR: signout\(signOutError.localizedDescription)")
        }
    
    }
}
