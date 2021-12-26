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
    
    var redColor: CIColor!
    var greenColor: CIColor!
    var blueColor: CIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.color = view.backgroundColor
    }
    
}

extension StartViewController: SettingsViewControllerDelegate {
    func setValue(for background: UIColor) {
        view.backgroundColor = background
    }
}
