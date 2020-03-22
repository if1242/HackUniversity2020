//
//  FriendsListViewController.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import UIKit

protocol FriendsListViewControllerOutput: AnyObject {
     
    var view: FriendsListViewControllerInput? { get set }
    
    func viewDidLoad()
    func didTapOnUser(_ user: RightechModel)
}

class FriendsListViewController: UIViewController {
    
    private var friends = [RightechModel]()
    
    private enum Constants {
        static let cellId = "cellId"
    }
    
    private lazy var friendsTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var output: FriendsListViewControllerOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Мои друзья"
        view.addSubview(friendsTableView)
        output?.viewDidLoad()
    }
    
    private func buildMap(id: Int) -> UIViewController {
        let vc = MapViewController()
        let presenter = MapPresenter()
        presenter.view = vc
        vc.output = presenter
        return vc
    }
}

extension FriendsListViewController: FriendsListViewControllerInput {
    
    func reloadData(with users: [RightechModel]) {
        friends = users
        friendsTableView.reloadData()
    }
    
    func showMap(with hereId: Int) {
        navigationController?.pushViewController(buildMap(id: hereId), animated: true)
    }
}

extension FriendsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
//        print(friends[indexPath.row])
        output?.didTapOnUser(friends[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FriendsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: Constants.cellId)
        }
        cell?.textLabel?.text = friends[indexPath.row].name
        return cell!
    }
}
