//
//  StartViewController.swift
//  HomeWork2.2
//
//  Created by Roman on 24.12.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setValue(for background: UIColor)
    
}

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigatioVC = segue.destination as? UINavigationController else { return }
        guard let settingsVC = navigatioVC.topViewController as? SettingsViewController else { return }
        settingsVC.delegate = self
        
    }
    
}

extension StartViewController: SettingsViewControllerDelegate {
    func setValue(for background: UIColor) {
        view.backgroundColor = background
    }
}
