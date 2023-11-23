//
//  DonateViewController.swift
//  DevFest
//
//  Created by Raj Salla on 2023-11-23.
//

import UIKit
import FirebaseStorage

class DonateViewController: UITableViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleView: UITextField!
    @IBOutlet weak var productRating: UITextField!
    @IBOutlet weak var productDescriptionView: UITextField!
    
    weak var delegate: SecondViewControllerDelegate?
    
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(productImageView(tapGestureRecognizer:)))
        productImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func productImageView(tapGestureRecognizer: UITapGestureRecognizer){
        openGallery()
    }
    
    @IBAction func donateButtonTapped(_ sender: Any) {
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
        
            // profile image selected
            if let title = productTitleView.text, let description = productDescriptionView.text{
                if title == ""{
                    print("Please enter title")
                }else if description == "" {
                    print("Please enter description")
                } else {
                    
                    self.dismiss(animated: true) {
                        self.delegate?.secondViewControllerDidFinish()
                    }
                    //self.navigationController?.dismiss(animated: true, completion: {
                    //})
                    
                }
            }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DonateViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
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
            productImageView.image = img
        }
        dismiss(animated: true)
    }
}


protocol SecondViewControllerDelegate: AnyObject {
    func secondViewControllerDidFinish()
}
