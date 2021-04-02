//
//  ViewController.swift
//  Runner
//
//  Created by Jefferson Moran on 03/03/21.
//

import UIKit
import FireworkVideo

class ViewController: FlutterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pushFeedOnNavigationController()
    }

    func pushFeedOnNavigationController() {
        let gridVC = VideoFeedViewController()
        gridVC.view.backgroundColor = .systemBackground
        let layout = VideoFeedGridLayout()
        layout.numberOfColumns = 3
        layout.contentInsets = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        gridVC.layout = layout
        var config = gridVC.viewConfiguration
        config.backgroundColor = .white
        gridVC.viewConfiguration.playerView.videoCompleteAction = .loop
        gridVC.viewConfiguration = config
        self.navigationController?.pushViewController(gridVC, animated: true)
    }

}
