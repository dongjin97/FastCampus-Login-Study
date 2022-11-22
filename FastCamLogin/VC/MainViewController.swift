//
//  MainViewController.swift
//  FastCamLogin
//
//  Created by 원동진 on 2022/11/03.
//

import UIKit
import FirebaseAuth
class MainViewController: UIViewController {

    @IBOutlet weak var resetPasswordButton: UIButton!
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
        
        //이메일 번호로 로그인하지 않았다면 버튼을 숨김
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID=="password"
        resetPasswordButton.isHidden = !isEmailSignIn
    }

    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        //로그인 방식과 는 상관없이 정상적으로 사용가능
        do{
            try firebaseAuth.signOut()
            //버튼 눌렀을때 첫번째화면으로 넘어감
            self.navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError {
            print("ERROR: signout\(signOutError.localizedDescription)")
        }
    }
    
    @IBAction func resetPasswordButotn(_ sender: UIButton) {
        //이메일로 로그인했을시 비밀번호 변경
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email,completion: nil)
    }
    @IBAction func profileUpdateButtonTapped(_ sender: UIButton) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "갱갱"
        changeRequest?.commitChanges(completion: { _ in
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
            self.welcomeLabel.text = """
                환영합니다.
                \(displayName)님
                """
        })
    }
}
