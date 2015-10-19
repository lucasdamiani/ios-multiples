//
//  ViewController.swift
//  Multiples
//
//  Created by Lucas Damiani on 18/10/15.
//  Copyright © 2015 Lucas Damiani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    private let threshold = 50
    private var multiple = 0
    private var sum = 0 {
        didSet {
            addLabel.text = "\(oldValue) + \(multiple) = \(sum)"
        }
    }
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var multipleTextField: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = nil
        addDoneButton(textField)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func play() {
        if canStartGame() {
            multiple = Int(multipleTextField.text!)!
            startGame()
        }
    }
    
    @IBAction func add() {
        sum += multiple
        
        if isGameOver() {
            resetGameData()
            endGame()
        }
    }
    
    private func canStartGame() -> Bool {
        return multipleTextField.hasText()
    }
    
    private func startGame() {
        toggleGameState()
    }
    
    private func isGameOver() -> Bool {
        return sum >= threshold
    }
    
    private func resetGameData() {
        multiple = 0
        sum = 0
    }
    
    private func endGame() {
        addLabel.text = "Press Add to add!"
        toggleGameState()
    }
    
    private func toggleGameState() {
        logoImageView.hidden = !logoImageView.hidden
        multipleTextField.hidden = !multipleTextField.hidden
        playButton.hidden = !playButton.hidden
        addLabel.hidden = !addLabel.hidden
        addButton.hidden = !addButton.hidden
    }
    
    private func addDoneButton(textField: UITextField!) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace,
            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .Done,
            target: view, action: Selector("endEditing:"))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
}

