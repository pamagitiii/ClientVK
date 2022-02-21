//
//  Extension.swift
//  GB_VK
//
//  Created by Anatoliy on 30.11.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(urlPatch: String?) {
        guard let urlPatch = urlPatch, let url = URL(string: urlPatch) else { return }
        print(urlPatch)
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}

extension UITableView {
    func showEmptyMessage(_ message: String) {
        let label: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = .systemGray
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            
            return label
        }()
        label.text = message
        self.backgroundView = label
    }
    
    func hideEmptyMessage() {
        self.backgroundView = nil
    }
}
