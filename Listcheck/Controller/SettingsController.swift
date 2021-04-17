//
//  SettingsController.swift
//  Listcheck
//
//  Created by Abraham Estrada on 3/30/21.
//

import UIKit

private let reuseIdentifier = "Cell"
private let headerIdentifier = "Header"

enum settings: Int, CaseIterable {
    case Permission
    case Frameworks
    case deleteAll
    
    var title: String {
        switch self {
        case .Permission: return "App Permisions"
        case .Frameworks: return "Frameworks Used"
        case .deleteAll: return "Delete All Tasks"
        }
    }
    
    var icon: String {
        switch self {
        case .Permission: return "person.2.fill"
        case .Frameworks: return "gear"
        case .deleteAll: return "clear"
        }
    }
}

class SettingsController: UICollectionViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "Settings"
        collectionView.backgroundColor = #colorLiteral(red: 0.9348467588, green: 0.9434723258, blue: 0.9651080966, alpha: 1)
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(SettingsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    func showDeleteAllAlert() {
        let alert = UIAlertController(title: "Delete All Tasks", message: "Are you sure you want to delete all tasks? This cannot be undone.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete All", style: .destructive, handler: {_ in DatabaseService.deleteAllTasks()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.view.tintColor = #colorLiteral(red: 0.4289224148, green: 0.317163229, blue: 1, alpha: 1)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension SettingsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        cell.label.text = settings(rawValue: indexPath.row)?.title
        cell.icon.image = UIImage(systemName: settings(rawValue: indexPath.row)!.icon)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath)
        return header
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SettingsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 225)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: NotificationService.goToAppPermissions()
        case 1: showMessage(withTitle: "Frameworks Used", message: "RealmSwift\nIQKeyboardManagerSwift")
        case 2: showDeleteAllAlert()
        default: break
        }
    }
}
