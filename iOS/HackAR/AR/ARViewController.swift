//
//  ARViewController.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation

protocol ARViewControllerOutput: AnyObject {
    
    var view: ARViewControllerInput? { get set }
    
    func viewDidLoad()
}

class ARViewController: UIViewController {
    
    private let configuration: ARConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        return configuration
    }()
    
    private lazy var arScene: ARSCNView = {
        let scene = ARSCNView(frame: self.view.bounds)
        scene.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        scene.scene = SCNScene()
        scene.delegate = self
        return scene
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var output: ARViewControllerOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(arScene)
        view.addSubview(distanceLabel)
        distanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        arScene.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        arScene.session.pause()
    }
}

extension ARViewController: ARSCNViewDelegate {
    
}

extension ARViewController: ARViewControllerInput {
    
    func showNode(_ node: SCNNode) {
        arScene.scene.rootNode.addChildNode(node)
    }
    
    func updateDistance(_ value: Int) {
        distanceLabel.text = "\(value) m"
    }
}
