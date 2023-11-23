//
//  DonateViewController.swift
//  DevFest
//
//  Created by Raj Salla on 2023-11-23.
//
import Foundation

final class ProductViewModel {

    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure

    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: [Product].self,
            type: ProductEndPoint.products) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let products):
                    self.products = products
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }

    func addProduct(parameters: AddProduct) {
        APIManager.shared.request(
            modelType: AddProduct.self, // response type
            type: ProductEndPoint.addProduct(product: parameters)) { [self] result in
                switch result {
                case .success(let product):
                    let addedProduct = Product(id: product.id!, title: product.title, price: product.price, description: product.description, category: product.category, image: product.image, rating: Rate(rate: 4.0, count: 400))
                    products.insert(addedProduct, at: 0)
                    self.eventHandler?(.newProductAdded(product: product))
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }


    func deleteProduct(index: Int) {
        products.remove(at: index)
        self.eventHandler?(.dataLoaded)
    }

    func updateProduct(product: Product, index: Int){
        products.insert(product, at: index)
        self.eventHandler?(.dataLoaded)
    }
    /*
    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    */

}

extension ProductViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newProductAdded(product: AddProduct)
    }

}
