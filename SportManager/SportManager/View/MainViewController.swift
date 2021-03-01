//
//  MainViewController.swift
//  SportManager
//
//  Created by Евгений on 01.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var dataManager: CoreDataManager!
    var playerArray = [Player]()
    var selectedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [])
}
