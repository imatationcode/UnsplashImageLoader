//
//  CustomeImageCollectionViewCell.swift
//  ImageFetchingApp
//
//  Created by Shivakumar Harijan on 22/12/24.
//

import UIKit

class CustomeImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        // Basic image loading from URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}

