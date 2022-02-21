//
//  AvailableGroupsTableViewCell.swift
//  GB_VK
//
//  Created by Anatoliy on 09.11.2021.
//

import UIKit

class AvailableGroupsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avGroupName: UILabel!
    @IBOutlet weak var avGroupPicture: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        showAnimatingDotsInImageView()
//    }
    
    func configure(group: Group) {
        selectionStyle = .none

        self.avGroupPicture.downloadImage(urlPatch: group.pictureURL)
        self.avGroupName.text = group.name
    }
    
    //Из ДЗ - нужно было создать анимвцию с тремя точками для загрузки
    func showAnimatingDotsInImageView() {
        
        let lay = CAReplicatorLayer()
        lay.frame = CGRect(x: avGroupPicture.bounds.minX + 10, y: avGroupPicture.bounds.midY - 7, width: 30, height: 7) //CGRect(x: avGroupPicture.bounds.origin.x + 10, y: avGroupPicture.bounds.midY - 7, width: 15, height: 7) //yPos == 12
        
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 7, height: 7)
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor(red: 110/255.0, green: 110/255.0, blue: 110/255.0, alpha: 1).cgColor//lightGray.cgColor //UIColor.black.cgColor
        lay.addSublayer(circle)
        lay.instanceCount = 3
        
        lay.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)

        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        lay.instanceDelay = anim.duration / Double(lay.instanceCount)
        
        avGroupPicture.layer.addSublayer(lay)
   
    }
}
