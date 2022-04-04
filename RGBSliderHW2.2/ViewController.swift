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
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var delegate: SettingsViewControllerProtocol!
    var color: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorRGBView.layer.cornerRadius = 15
        colorRGBView.backgroundColor = color
        
        setSliders()
        setValueLabel(for: redLabel, greenLabel, blueLabel)
        setValueTextField(for: redTextField, greenTextField, blueTextField)
        
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func rgbSliders(_ sender: UISlider) {
        viewColor()
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    @IBAction func saveButtonRGB(_ sender: Any) {
        delegate.settingsView(color: colorRGBView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
}

//MARK: - Privet Func
extension ViewController {
    
    private func setSliders() {
        let ciColor = CIColor(color: color)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func viewColor() {
        colorRGBView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValueLabel(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValueTextField(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                redTextField.text = string(from: redSlider)
            case greenTextField:
                greenTextField.text = string(from: greenSlider)
            default:
                blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func alertController(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func addDoneButtonTo(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace,
                                            target: nil,
                                            action: nil)
        keyboardToolbar.setItems([flexBarButton, doneButton], animated: false)
    }
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        if let numbervalue = Float(newValue) {
        
        switch textField {
        case redTextField:
            redSlider.value = numbervalue
            setValueLabel(for: redLabel)
        case greenTextField:
            greenSlider.value = numbervalue
            setValueLabel(for: greenLabel)
        case blueTextField:
            blueSlider.value = numbervalue
            setValueLabel(for: blueLabel)
        default: break
        }
            
        viewColor()
            
        } else {
            alertController(title: "Внимание", message: "Не верный формат ввода")
        }
    }



}


