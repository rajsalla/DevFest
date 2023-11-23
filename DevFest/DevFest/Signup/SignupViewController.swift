//
//  DonateViewController.swift
//  DevFest
//
//  Created by Raj Salla on 2023-11-23.
//

import UIKit
import FirebaseAuth

class SignupViewController: UITableViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgProfile.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        openGallery()
    }
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
        
        if imgProfile.image?.pngData() != imgSystem?.pngData(){
            // profile image selected
            if let email = txtEmail.text, let password = txtPassword.text, let username = txtUsername.text, let conPassword = txtConPassword.text{
                if username == ""{
                    print("Please enter username")
                }else if !email.validateEmailId(){
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("email is not valid")
                }else if !password.validatePassword(){
                    print("Password is not valid")
                } else{
                    if conPassword == ""{
                        print("Please confirm password")
                    }else{
                        if password == conPassword{
                            // navigation code
                            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                if let error = error as? NSError {
                                    print(error.localizedDescription)
                                } else {
                                    print("Sign Up Successfull")
                                    let newUserInfo = Auth.auth().currentUser
                                    let email = newUserInfo?.email
                                    
                                    //Navigate
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                                    if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                                        nextViewController.modalPresentationStyle = .fullScreen
                                        self.present(nextViewController, animated:true, completion:nil)
                                    }
                                }
                                
                            }
                            print("Navigation code Yeah!")
                        }else{
                            print("password does not match")
                        }
                    }
                }
            }else{
                print("Please check your details")
            }
        }else{
            print("Please select profile picture")
            openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UIScreen.main.bounds.height
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
}

extension SignupViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            imgProfile.image = img
        }
        dismiss(animated: true)
    }
}
