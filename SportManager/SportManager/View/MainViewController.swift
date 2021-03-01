//
//  MainViewController.swift
//  SportManager
//
//  Created by Евгений on 01.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    var dataManager: CoreDataManager!
    
    private var playerArray = [Player]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.identifierCell)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        title = "Players"
        
        let addPlayerBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(pressedAddPlayer))
        
        navigationItem.rightBarButtonItem = addPlayerBarButtonItem
    }
    
    @objc private func pressedAddPlayer() {
        let viewController = PlayerViewController()
        viewController.dataManager = dataManager
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func fetchData() {
        playerArray = dataManager.fetchData(for: Player.self)
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.identifierCell, for: indexPath) as! PlayerCell
        let item = playerArray[indexPath.row]
        cell.createCell(model: item)
        
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            dataManager.delete(object: playerArray[indexPath.row])
            fetchData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
}


