//
//  SettingsCell.swift
//  Listcheck
//
//  Created by Abraham Estrada on 4/6/21.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()
    
    var icon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.tintColor = #colorLiteral(red: 0.4274509804, green: 0.3176470588, blue: 1, alpha: 1)
        return iv
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "testing test"
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(roundedView)
        roundedView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        addSubview(icon)
        icon.centerY(inView: self)
        icon.anchor(left: leftAnchor,paddingLeft: 25)
        icon.setDimensions(height: self.frame.height - 40, width: self.frame.height - 40)
        
        addSubview(label)
        label.centerY(inView: self)
        label.anchor(left: icon.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 32)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
