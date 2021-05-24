//
//  ViewController.swift
//  RxTagView
//
//  Created by Michael Eid on 5/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var rxTagView: RxTagsView = {
        let rxTagView = RxTagsView()
        rxTagView.translatesAutoresizingMaskIntoConstraints = false
        return rxTagView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }


    private func setupView() {
        view.backgroundColor = UIColor.systemYellow

        view.addSubview(rxTagView)

        NSLayoutConstraint.activate([
            rxTagView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rxTagView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rxTagView.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        let titles = ["Swift", "Rx", "Combine", "Food", "Electron", "Other", "Swift", "Rx", "Combine", "Food", "Electron", "Other"]
        rxTagView.tags = titles
        rxTagView.backgroundColor = .systemBlue
        rxTagView.tagPressed = {
            print("Button pressed \($0)")
        }
    }


}

