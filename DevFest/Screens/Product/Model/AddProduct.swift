//
//  DonateViewController.swift
//  DevFest
//
//  Created by Raj Salla on 2023-11-23.
//
import Foundation

struct AddProduct: Codable {
    var id: Int? = nil
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
}
