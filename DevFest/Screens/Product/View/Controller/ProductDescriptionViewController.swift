//
//  ProductDescriptionViewController.swift
//  DevFest
//
//  Created by Raj Salla on 2023-11-23.
//

import UIKit

class ProductDescriptionViewController: UIViewController {
    
    var product: Product?

    @IBOutlet weak var productTitleView: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productDescriptionView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let product = product{
            productTitleView.text = product.title
            productDescriptionView.text = product.description
            productImageView.setImage(with: product.image)
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
