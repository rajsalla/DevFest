//
//  DonateViewController.swift
//  DevFest
//
//  Created by Raj Salla on 2023-11-23.
//

import UIKit

class AddProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addProduct()
    }

    func addProduct() {
        //guard let url = URL(string: "https://dummyjson.com/products/add") else { return }
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }

        let parameters = AddProduct(title: "test product", price: 13.5, description: "lorem ipsum set", category: "electronic", image: "https://i.pravatar.cc")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Model to Data Convert (JSONEncoder() + Encodable)
        request.httpBody = try? JSONEncoder().encode(parameters)

        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                // Data to Model convert - JSONDecoder() + Decodable
                let productResponse = try JSONDecoder().decode(AddProduct.self, from: data)
                print(productResponse)
            }catch {
                print(error)
            }
        }.resume()
    }


}
