//
//  UserPictureView.swift
//  GB_VK
//
//  Created by Anatoliy on 10.11.2021.
//

import UIKit

class UserPictureView: UIView {
    
    lazy var tapOnPhoto = UITapGestureRecognizer(target: self, action: #selector(animatePhoto))

    let imageView: UIImageView = {
        let image = UIImageView()
        //image.image = UIImage(named: "car")
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero //CGSize(width: 8.0, height: 8.0)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        return view
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubview(shadowView)
        addSubview(imageView)
        
        imageView.addGestureRecognizer(tapOnPhoto)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.frame = bounds //CGRect(x: 0, y: 0, width: bounds.width , height: bounds.height )
        imageView.frame = bounds
        
        shadowView.center = imageView.center
        
        shadowView.layer.cornerRadius = bounds.height / 2
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = bounds.height / 2
        
        shadowView.layer.shadowPath = UIBezierPath(ovalIn: shadowView.bounds).cgPath
    }
    
    private func setupView() {
        addSubview(shadowView)
        addSubview(imageView)
    }
    
    @objc private func animatePhoto() {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: []) {
            self.imageView.frame = CGRect(x: self.imageView.frame.minX, y: self.imageView.frame.minY, width: self.imageView.frame.width - 5, height: self.imageView.frame.height - 5)
        }
    }
}
