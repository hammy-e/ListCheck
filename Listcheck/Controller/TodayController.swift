//
//  TodayController.swift
//  Listcheck
//
//  Created by Abraham Estrada on 3/30/21.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"
private let headerIdentifier = "TodayHeader"
private let sectionIdentifier = "Section"

class TodayController: UICollectionViewController, TaskCellDelegate {
    
    // MARK: - Properties
    
    private var tasks = realm.objects(Task.self)
    private var todayUncompletedTasks = [Task]()
    private var todayCompletedTasks = [Task]()
    
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
    
    func editTask(_ task: Task) {
        let controller = ViewTaskController()
        controller.task = task
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        navigationItem.title = "Today"
        collectionView.backgroundColor = #colorLiteral(red: 0.9348467588, green: 0.9434723258, blue: 0.9651080966, alpha: 1)
        collectionView.alwaysBounceVertical = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.rectangle"), style: .plain, target: self, action: #selector(handleNewTask))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(TodayHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
    }
    
    func updateTasks() {
        tasks = tasks.sorted(byKeyPath: "dateDue", ascending: true)
        todayUncompletedTasks = tasks.filter {(!$0.isCompleted && $0.dateDue.toMonthDayYear() == Date().toMonthDayYear())}
        todayCompletedTasks = tasks.filter {$0.isCompleted && $0.dateCompleted?.toMonthDayYear() == Date().toMonthDayYear()}
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension TodayController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? todayUncompletedTasks.count : todayCompletedTasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TaskCell
        
        switch indexPath.section {
        case 0: cell.task = todayUncompletedTasks[indexPath.row]; cell.delegate = self
        case 1: cell.task = todayCompletedTasks[indexPath.row]; cell.delegate = self
        default: break
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TodayHeader
            header.itemsLeftToDoLabel.text = todayUncompletedTasks.count != 1 ? "\(todayUncompletedTasks.count) Tasks due today." : "\(todayUncompletedTasks.count) Task due today."
            return header
        } else {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionIdentifier, for: indexPath) as! SectionHeader
            sectionHeader.label.text = todayCompletedTasks.count != 1 ? "\(todayCompletedTasks.count) Tasks completed today." : "\(todayCompletedTasks.count) Task completed today."
            return sectionHeader
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: view.frame.width, height: 175) : CGSize(width: view.frame.width, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: editTask(todayUncompletedTasks[indexPath.row])
        case 1: editTask(todayCompletedTasks[indexPath.row])
        default: break
        }
    }
}
