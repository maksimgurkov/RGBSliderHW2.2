//
//  ResultViewController.swift
//  RGBSliderHW2.2
//
//  Created by Максим Гурков on 03.04.2022.
//

import UIKit

protocol SettingsViewControllerProtocol {
    func settingsView(color: UIColor)
}

class ResultViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? ViewController else { return }
        settingsVC.delegate = self
        settingsVC.color = view.backgroundColor
        
    }

}

extension ResultViewController: SettingsViewControllerProtocol {
    func settingsView(color: UIColor) {
        view.backgroundColor = color
    }
    
    
}
