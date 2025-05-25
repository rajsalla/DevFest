//
//  DonateViewController.swift
//  DevFest
//
//  Created by Raj Salla on 2023-11-23.
//
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        //let resource = ImageResource(name: url, bundle: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}

