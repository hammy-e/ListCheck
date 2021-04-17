//
//  ToDoCell.swift
//  Listcheck
//
//  Created by Abraham Estrada on 3/30/21.
//

import UIKit

protocol TaskCellDelegate: class {
    func updateTasks()
}

class TaskCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: TaskCellDelegate?
    
    var task: Task? {
        didSet{updateCellUI()}
    }
    
    private let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = #colorLiteral(red: 0.4274509804, green: 0.3176470588, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(handleCheckTapped), for: .touchUpInside)
        return button
    }()
    
    var toDoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(roundedView)
        roundedView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        addSubview(checkButton)
        checkButton.centerY(inView: self)
        checkButton.anchor(left: leftAnchor,paddingLeft: 25)
        checkButton.setDimensions(height: self.frame.height - 40, width: self.frame.height - 40)
        
        addSubview(toDoLabel)
        toDoLabel.centerY(inView: self)
        toDoLabel.anchor(left: checkButton.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 32)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func handleCheckTapped() {
        guard let task = task else {return}
        DatabaseService.toggleIsCompleted(task)
        updateCellUI()
        delegate?.updateTasks()
        generateHapticFeedback()
    }
    
    // MARK: - Helpers
    
    func updateCellUI() {
        guard let task = task else {return}
        
        checkButton.setBackgroundImage(UIImage(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle"), for: .normal)
        toDoLabel.attributedText = getTaskAttributedString(title: task.title, time: task.dateCompleted == nil && task.dateDue.toMonthDayYear() == Date().toMonthDayYear() ? task.dateDue.getTime() : task.dateDue.toString())
        toDoLabel.textColor = task.dateDue < Date() && !task.isCompleted ? .red : .black
    }
    
    func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func getTaskAttributedString(title: String, time: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedString.append(NSAttributedString(string: "   \(time)", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        return attributedString
    }
}
