//
//  ViewController.swift
//  Silly Song
//
//  Created by Miika Sirén on 9/6/17.
//  Copyright © 2017 devglyph. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        let name = nameField.text?.capitalized
        if !((name?.isEmpty)!) {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name!)
        }
    }
}

// join an array of strings into a single template string:
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercased()
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    
    if let firstVowelRange = lowercaseName.rangeOfCharacter(from: vowelSet as CharacterSet) {
        return lowercaseName.substring(from: firstVowelRange.lowerBound)
    }
    
    return lowercaseName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    return lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
