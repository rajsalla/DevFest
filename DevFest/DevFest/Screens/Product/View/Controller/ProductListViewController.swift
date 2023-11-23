//
//  DonateViewController.swift
//  DevFest
//
//  Created by Raj Salla on 2023-11-23.
//

import UIKit

class ProductListViewController: UIViewController, SecondViewControllerDelegate, UISearchBarDelegate {

    // MARK: - Outlets
    @IBOutlet weak var productTableView: UITableView!

    // MARK: - Variables
    private var viewModel = ProductViewModel()
    
   // let categories : [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    func secondViewControllerDidFinish() {
        // Reload your table view or perform any other necessary actions
        let product = AddProduct(title: "test product", price: 13.5, description: "lorem ipsum set", category: "electronic", image: "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg")
        viewModel.addProduct(parameters: product)
        //configuration()
    }

    @IBAction func addProductButtonTapped(_ sender: UIBarButtonItem) {
        let product = AddProduct(title: "test product", price: 13.5, description: "lorem ipsum set", category: "electronic", image: "https://i.pravatar.cc")
        viewModel.addProduct(parameters: product)
    }
    @IBAction func donateButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if let donateViewController = storyBoard.instantiateViewController(withIdentifier: "DonateViewController") as? DonateViewController {
            donateViewController.delegate = self
            self.present(donateViewController, animated:true, completion:nil)
        }
    }
}

extension ProductListViewController {

    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }

    func initViewModel() {
        viewModel.fetchProducts()
    }

    // Data binding event observe karega - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }

            switch event {
            case .loading:
                /// Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide kardo
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            case .newProductAdded(let newProduct):
                print("Obeserver+++\(newProduct)")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.productTableView.reloadData()
                }
            }
        }
    }

}

extension ProductListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    

}

extension ProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        vc.product = viewModel.products[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.viewModel.deleteProduct(index: indexPath.row)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
        return swipeConfiguration
    }
}
