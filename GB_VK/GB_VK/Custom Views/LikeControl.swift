//
//  LikeControl.swift
//  GB_VK
//
//  Created by Anatoliy on 10.11.2021.
//

import UIKit

class LikeControl: UIControl {
    
    var likesCountInt: Int = 0
    
    var isLiked: Bool = false
//    {
//        didSet {
//            //changeLikeConrol()
//        }
//    }
    
    let likesCountLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.text = "0"
        
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        //button.imageView?.image = UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let backgroundVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let backgroundVisualEffect = UIVisualEffectView(effect: blurEffect)
        backgroundVisualEffect.layer.cornerRadius = 10
        return backgroundVisualEffect
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        likesCountLabel.frame = CGRect(x: 0,
                                       y: 0,
                                       width: bounds.width * 0.6,
                                       height: bounds.height)
        
        likeButton.frame = CGRect(x: likesCountLabel.frame.maxX + 1,
                                  y: likesCountLabel.frame.minY,
                                  width: bounds.width * 0.4,
                                  height: bounds.height)
    }
    
    private func setupViews() {

        addSubview(likesCountLabel)
        addSubview(likeButton)

    }
    
    @objc private func likeTapped() {
        changeLikeConrol()
        isLiked.toggle()
    }
    
    private func changeLikeConrol() {
        if isLiked == true {
            //likesCountLabel.text = "0"
           // likesCountLabel.textColor = .systemBlue
            
            let currentValue = Int(self.likesCountLabel.text ?? "0") ?? 0
            let newValue = currentValue - 1
            
            UIView.transition(with: likeButton, duration: 0.5, options: .transitionCrossDissolve) {
                self.likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            }
            
            UIView.transition(with: likesCountLabel, duration: 0.2, options: .transitionCrossDissolve) {
                self.likesCountLabel.text = String(describing: newValue)
                self.likesCountLabel.textColor = .systemBlue
            }
            
        } else {
            //likesCountLabel.text = "1"
            //likesCountLabel.textColor = .systemRed
            
            let currentValue = Int(self.likesCountLabel.text ?? "0") ?? 0
            let newValue = currentValue + 1
            

            UIView.transition(with: likeButton, duration: 0.5, options: .transitionCrossDissolve) {
                self.likeButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
            }
            
            UIView.transition(with: likesCountLabel, duration: 0.5, options: .transitionCrossDissolve) {
                self.likesCountLabel.text = String(describing: newValue)
                self.likesCountLabel.textColor = .systemRed
            }
        }
    }
    
}
