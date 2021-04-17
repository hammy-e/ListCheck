//
//  ToDoHeader.swift
//  Listcheck
//
//  Created by Abraham Estrada on 3/30/21.
//

import UIKit

class TodayHeader: UICollectionReusableView  {
    
    // MARK: - Properties
    
    private let todaysDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    var itemsLeftToDoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "4 Tasks left to do today."
        label.textColor = .white
        return label
    }()
    
    private let itemsLeftToDoBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(todaysDateLabel)
        todaysDateLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 20)
        todaysDateLabel.attributedText = getDateAttributtedString(Date())
        
        addSubview(itemsLeftToDoBorderView)
        itemsLeftToDoBorderView.anchor(top: todaysDateLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)
        itemsLeftToDoBorderView.setDimensions(height: 35, width: self.frame.width)
        
        addSubview(itemsLeftToDoLabel)
        itemsLeftToDoLabel.center(inView: itemsLeftToDoBorderView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func getDateAttributtedString(_ date: Date) -> NSAttributedString {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        var dateString = formatter.string(from: date)
        
        let attributedString = NSMutableAttributedString(string: "\(dateString)\n", attributes: [.font: UIFont.systemFont(ofSize: 24)])
        
        formatter.dateFormat = "MMMM d, yyyy"
        dateString = formatter.string(from: date)
        
        attributedString.append(NSAttributedString(string: dateString, attributes: [.font: UIFont.boldSystemFont(ofSize: 36)]))
        return attributedString
    }
}
