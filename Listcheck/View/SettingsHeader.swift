//
//  SettingsHeader.swift
//  Listcheck
//
//  Created by Abraham Estrada on 4/6/21.
//

import UIKit

class SettingsHeader: UICollectionReusableView  {
    
    // MARK: - Properties
    
    let appIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "listcheckIcon")
        iv.setDimensions(height: 100, width: 100)
        iv.layer.cornerRadius = 100 / 2
        return iv
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Listcheck\nVersion 1.0\nMade by Abraham Estrada"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appIcon)
        appIcon.centerX(inView: self)
        appIcon.anchor(top: topAnchor, paddingTop: 18)
        
        addSubview(label)
        label.centerX(inView: self)
        label.anchor(top: appIcon.bottomAnchor, paddingTop: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
