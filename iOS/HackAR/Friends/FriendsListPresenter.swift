//
//  FriendsListPresenter.swift
//  HackAR
//
//  Created by viktor.volkov on 22.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import Foundation

protocol FriendsListViewControllerInput: AnyObject {
    
    var output: FriendsListViewControllerOutput? { get set }
    
    func reloadData(with users: [RightechModel])
    func showMap(with hereId: Int)
}

class FriendsListPresenter {
    
    weak var view: FriendsListViewControllerInput?
    private let service = FriendsListService()
    private var models = [RightechModel]()
}

extension FriendsListPresenter: FriendsListViewControllerOutput {
    
    func viewDidLoad() {
        service.loadUsers {
            [weak self] result in
            
            switch result {
            case .success(let models):
                self?.models = models
                DispatchQueue.main.async {
                    self?
                        .view?
                        .reloadData(with: models.filter { $0.type == "студент" })
                }
                print(models)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapOnUser(_ user: RightechModel) {
        guard let mac = user.state.MAC else {
            return
        }
        
        let sensors = models.filter { $0.type == "датчик" }
        guard let active = (sensors.first { $0.state.payloads.contains(mac) }) else {
            return
        }
        guard let hereId = active.state.HereID else {
            return
        }
        view?.showMap(with: hereId)
    }
}
