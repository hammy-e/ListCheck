//
//  ViewTaskController.swift
//  Listcheck
//
//  Created by Abraham Estrada on 4/2/21.
//

import UIKit

class ViewTaskController: UIViewController {
    
    // MARK: - Properties
    
    var task: Task? = nil {
        didSet{
            guard let task = task else {return}
            titleTextField.text = task.title
            descriptionTextField.text = task.taskDescription
            datePicker.date = task.dateDue
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 75)
        return scroll
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    private let titleTextField: UITextView = {
        let tf = UITextView()
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.layer.cornerRadius = 20
        tf.textAlignment = .center
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        label.text = "Description"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    private let descriptionTextField: UITextView = {
        let tf = UITextView()
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.layer.cornerRadius = 20
        tf.textAlignment = .center
        tf.layer.masksToBounds = true
        return tf
    }()
    
    private let dateImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "calendar")
        iv.tintColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 25, width: 25)
        return iv
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        label.text = "Date"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.tintColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        picker.preferredDatePickerStyle = .compact
        return picker
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        button.setTitle("Update", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleUpdateTapped), for: .touchUpInside)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle("Delete", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleSaveTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func handleUpdateTapped() {
        guard let task = task else {return}
        let updatedTask = Task()
        updatedTask.title = titleTextField.text ?? "No Title"
        updatedTask.taskDescription = descriptionTextField.text ?? ""
        updatedTask.dateDue = datePicker.date
        updatedTask.isCompleted = task.isCompleted
        updatedTask.dateCompleted = task.dateCompleted ?? nil
        DatabaseService.deleteTask(task)
        DatabaseService.addTask(updatedTask)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSaveTapped() {
        guard let task = task else {return}
        navigationController?.popViewController(animated: true)
        DatabaseService.deleteTask(task)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "Edit Task"
        view.backgroundColor = #colorLiteral(red: 0.9348467588, green: 0.9434723258, blue: 0.9651080966, alpha: 1)
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.alwaysBounceVertical = true
        
        scrollView.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top: scrollView.topAnchor, paddingTop: 25)
        
        scrollView.addSubview(titleTextField)
        titleTextField.centerX(inView: view)
        titleTextField.anchor(top: titleLabel.bottomAnchor, paddingTop: 12, width: view.frame.width - 50, height: 50)
        
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.centerX(inView: view)
        descriptionLabel.anchor(top: titleTextField.bottomAnchor, paddingTop: 36)
        
        scrollView.addSubview(descriptionTextField)
        descriptionTextField.centerX(inView: view)
        descriptionTextField.anchor(top: descriptionLabel.bottomAnchor, paddingTop: 12, width: view.frame.width - 50, height: 100)
        
        let stack = UIStackView(arrangedSubviews: [dateImageView, dateLabel])
        stack.axis = .horizontal
        
        scrollView.addSubview(stack)
        stack.anchor(top: descriptionTextField.bottomAnchor, paddingTop: 36)
        stack.centerX(inView: view)
        stack.spacing = 15
        
        scrollView.addSubview(datePicker)
        datePicker.centerX(inView: view)
        datePicker.anchor(top: stack.bottomAnchor,paddingTop: 12)
        
        scrollView.addSubview(updateButton)
        updateButton.setDimensions(height: 50, width: view.frame.width - 150)
        updateButton.centerX(inView: view)
        updateButton.anchor(top: datePicker.bottomAnchor, paddingTop: 36)
        
        scrollView.addSubview(deleteButton)
        deleteButton.setDimensions(height: 50, width: view.frame.width - 200)
        deleteButton.centerX(inView: view)
        deleteButton.anchor(top: updateButton.bottomAnchor, paddingTop: 12)
    }
}
