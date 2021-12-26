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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultOfSettingsView.layer.cornerRadius = 30

        maxValuesOfSliders()


        redSlider.value = 255
        greenSlider.value = 19
        blueSlider.value = 10

        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self

        maxTintColor()
        minTintColor()

        setColor()
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        
        
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
            red: CGFloat(redSlider.value / 255),
            green: CGFloat(greenSlider.value / 255),
            blue: CGFloat(blueSlider.value / 255), alpha: 1)
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
        String(format: "%.0f", slider.value )
    }
    
    private func maxValuesOfSliders() {
        redSlider.maximumValue = 255
        greenSlider.maximumValue = 255
        blueSlider.maximumValue = 255
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
            switch textField.tag {
            case 0 where 1...255 ~= newNumber:
                redSlider.value = newNumber
            case 1 where 0...255 ~= newNumber:
                greenSlider.value = newNumber
            case 2 where 0...255 ~= newNumber:
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
            


