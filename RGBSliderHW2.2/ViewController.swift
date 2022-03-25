//
//  ViewController.swift
//  RGBSliderHW2.2
//
//  Created by Максим Гурков on 25.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var colorRGBView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorRGBView.layer.cornerRadius = 15
        
        setValueForLabel()
        viewColor()
    }
    
    @IBAction func rgbSlider() {
        
        setValueForLabel()
        viewColor()
        
    }

}

//MARK: - Privet Func
extension ViewController {
    
    private func setValueForLabel() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func viewColor() {
        colorRGBView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                               green: CGFloat(greenSlider.value),
                                               blue: CGFloat(blueSlider.value),
                                               alpha: 1)
    }
    
}

