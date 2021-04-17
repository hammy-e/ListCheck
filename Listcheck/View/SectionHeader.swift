//
//  ToDoSectionHeader.swift
//  Listcheck
//
//  Created by Abraham Estrada on 4/2/21.
//

import UIKit

class SectionHeader: UICollectionReusableView  {
    
    // MARK: - Properties
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "4 Tasks left to do today."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
