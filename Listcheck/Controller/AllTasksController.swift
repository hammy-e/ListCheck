//
//  AllTasksController.swift
//  Listcheck
//
//  Created by Abraham Estrada on 3/30/21.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"
private let headerIdentifier = "Header"

class AllTasksController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var tasks = realm.objects(Task.self)
    private var uncompletedTasks = [Task]()
    private var completedTasks = [Task]()
    
    var currentFilter = "All" {
        didSet{updateTasks()}
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        updateTasks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateTasks()
    }
    
    // MARK: - Actions
    
    @objc func handleNewTask() {
        navigationController?.pushViewController(NewTaskController(), animated: true)
    }
    
    @objc func handleFilter() {
        let all = UIAlertAction(title: "All", style: .default) { _ in
            self.currentFilter = "All"
        }
        let completed = UIAlertAction(title: "Completed", style: .default) { _ in
            self.currentFilter = "Completed"
        }
        let uncompleted = UIAlertAction(title: "Uncompleted", style: .default) { _ in
            self.currentFilter = "Uncompleted"
        }
        
        let actionSheet = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(all)
        actionSheet.addAction(completed)
        actionSheet.addAction(uncompleted)
        actionSheet.view.tintColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        
        present(actionSheet, animated: true, completion: updateTasks)
    }
    
    func editTask(_ task: Task) {
        let controller = ViewTaskController()
        controller.task = task
        navigationController?.pushViewController(controller, animated: true)
    }

    
    // MARK: - Helpers
    
    func configureCollectionView() {
        navigationItem.title = "All Tasks"
        collectionView.backgroundColor = #colorLiteral(red: 0.9348467588, green: 0.9434723258, blue: 0.9651080966, alpha: 1)
        collectionView.alwaysBounceVertical = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.rectangle"), style: .plain, target: self, action: #selector(handleNewTask))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(handleFilter))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    func updateTasks() {
        tasks = tasks.sorted(byKeyPath: "dateDue", ascending: true)
        uncompletedTasks = tasks.filter {!$0.isCompleted}
        completedTasks = tasks.filter {$0.isCompleted}
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension AllTasksController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentFilter {
            case "All": return tasks.count
            case "Completed": return completedTasks.count
            case "Uncompleted": return uncompletedTasks.count
            default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TaskCell
        
        switch currentFilter {
            case "All": cell.task = tasks[indexPath.row]
            case "Completed": cell.task = completedTasks[indexPath.row]
            case "Uncompleted": cell.task = uncompletedTasks[indexPath.row]
            default: break
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! SectionHeader
        header.label.text = tasks.count != 1 ? "\(tasks.count) Total Tasks\nCurrent Filter: \(currentFilter)" : "\(tasks.count) Total Task\nCurrent Filter: \(currentFilter)"
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AllTasksController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch currentFilter {
            case "All": editTask(tasks[indexPath.row])
            case "Completed": editTask(completedTasks[indexPath.row])
            case "Uncompleted": editTask(uncompletedTasks[indexPath.row])
            default: break
        }
    }
}
