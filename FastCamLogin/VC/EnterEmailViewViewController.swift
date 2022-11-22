//
//  EnterEmailViewViewController.swift
//  FastCamLogin
//
//  Created by 원동진 on 2022/11/03.
//

import UIKit
import FirebaseAuth
class EnterEmailViewViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.becomeFirstResponder()
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false

    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else{return}
            //login이 제대로 끝났을때
            if let error = error {
                let code = (error as NSError).code
                switch code{
                case 17007: //이미 가입한계정
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            }else {
                self.showMainViewController()
            }
           
        }
    }
    //firebase인증을 통한 로그인
    private func loginUser(withEmail email: String , password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else{return}
            if let error = error{
                self.errorMessageLabel.text = error.localizedDescription
            }else{
                self.showMainViewController()
            }
        }
    }
    
    
    //다음 클릭시 mainView로이동
    private func showMainViewController(){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "MainViewController")
        mainVC.modalPresentationStyle = .fullScreen
        navigationController?.show(mainVC, sender: nil)
    }
    
}
extension EnterEmailViewViewController : UITextFieldDelegate{
    //return버튼 누를때 키보드가 내려가게함
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    //mac os keyboard사용시 return키 값이 enter이다 enter을 눌러야지 텍스트필드가 endEditing되기 때문에
    //enter을 눌러줘야함
    // 이메일,비밀번호 Text값이 있을때 다음 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        self.nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
