//
//  ViewController.swift
//  HomeWork2.2
//
//  Created by Roman on 10.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var resultOfSettingsView: UIView!
    
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    var color: UIColor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultOfSettingsView.backgroundColor = color
        
        resultOfSettingsView.backgroundColor = color
        resultOfSettingsView.layer.cornerRadius = 30
        
        maxValuesOfSliders()
        
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
        
        maxTintColor()
        minTintColor()
        
        colorSeparator()
        
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        addDoneButtonTo(redColorTextField, greenColorTextField, blueColorTextField)
        
        
        
    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case redSlider: setValue(for: redValueLabel)
        case greenSlider: setValue(for: greenValueLabel)
        default: setValue(for: blueValueLabel)
        }
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.setValue(for: resultOfSettingsView.backgroundColor ?? .blue)
        dismiss(animated: true)
    }
    
    
    //MARK: - Private methods
    
    private func setColor() {
        resultOfSettingsView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    private func colorSeparator() {
        let startColor = CIColor(color: color ?? .white)
        redSlider.value = Float(startColor.red)
        greenSlider.value = Float(startColor.green)
        blueSlider.value = Float(startColor.blue)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                label.text = string(from: redSlider )
                redColorTextField.text = label.text
            case greenValueLabel:
                label.text = string(from: greenSlider)
                greenColorTextField.text = label.text
            default:
                label.text = string(from: blueSlider)
                blueColorTextField.text = label.text
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value )
    }
    
    private func maxValuesOfSliders() {
        redSlider.maximumValue = 1
        greenSlider.maximumValue = 1
        blueSlider.maximumValue = 1
    }
    
    private func maxTintColor() {
        redSlider.maximumTrackTintColor = .white
        greenSlider.maximumTrackTintColor = .white
        blueSlider.maximumTrackTintColor = .white
    }
    
    private func minTintColor() {
        redSlider.minimumTrackTintColor = . red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
    
    
}
// MARK: - Keyboard methods
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        
        if let newNumber = Float(newValue) {
            guard 0...1 ~= newNumber else {
                switch textField.tag {
                case 0:
                    showAlert(title: "ERROR", message: "Input correct number from 1 to 255")
                case 1:
                    showAlert(title: "ERROR", message: "Input correct number from 0 to 255")
                case 2:
                    showAlert(title: "ERROR", message: "Input correct number from 0 to 255")
                default: break
                }
                return
            }
            switch textField.tag {
            case 0:
                redSlider.value = newNumber
            case 1:
                greenSlider.value = newNumber
            case 2:
                blueSlider.value = newNumber
            default: break
            }
            setColor()
            setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        } else {
            switch textField.tag {
            case 0:
                showAlert(title: "ERROR", message: "Input correct number from 1 to 255")
            case 1:
                showAlert(title: "ERROR", message: "Input correct number from 0 to 255")
            case 2:
                showAlert(title: "ERROR", message: "Input correct number from 0 to 255")
            default: break
            }
            
        }
        
    }
    
    private func addDoneButtonTo(_ textFields: UITextField...) {
        
        let numberToolbar = UIToolbar()
        numberToolbar.sizeToFit()
        textFields.forEach { textField in
            switch textField {
            case redColorTextField: textField.inputAccessoryView = numberToolbar
            case greenColorTextField: textField.inputAccessoryView = numberToolbar
            default: textField.inputAccessoryView = numberToolbar
            }
        }
        
        let doneButton = UIBarButtonItem(title:"Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(tapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        numberToolbar.items = [flexBarButton, doneButton]
        
    }
    
    @objc private func tapDone() {
        view.endEditing(true)
    }
    
    
    
}




// MARK: - Alert method
extension SettingsViewController {
    private func showAlert(title: String,  message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            
        }
        
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}


