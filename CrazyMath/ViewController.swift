//
//  ViewController.swift
//  CrazyMath
//
//  Created by zhussupov on 7/12/19.
//  Copyright © 2019 Zhussupov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var expressionLabel: UILabel!
  
  @IBOutlet weak var borderLine: UIView!
  
  @IBOutlet weak var scoreLabel: UILabel!
  
  @IBOutlet weak var submitButton: UIButton!
  
  @IBOutlet weak var answerTextField: UITextField!
  
  let speed: CGFloat = 0.4
  var answer = 0
  var score = 0
  
  var timer: Timer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerStep), userInfo: nil, repeats: true)
    RunLoop.current.add(timer!, forMode: .commonModes)
    newRound()
    answerTextField.keyboardType = .numberPad
    answerTextField.becomeFirstResponder()
    scoreLabel.text = "SCORE: 0"
  }
  
  @objc func timerStep() {
    changeLabelY(by: speed)
    let labelY = expressionLabel.frame.maxY
    let lineY = borderLine.frame.maxY
    if labelY > lineY {
     lost()
    }
  }
  
  func lost() {
    
    // lostCount += 1
    
    newRound()
  }
  
  private func setLabelY(_ y: CGFloat) {
    expressionLabel.frame.origin.y = y
  }
  
  func newRound() {
    setLabelY(70)
    expressionLabel.textAlignment = .center
    
    // generating new expression
    
    let (newExpression, ans) = generateExpression()
    answer = ans
    print(answer)
    expressionLabel.text = newExpression
    
  }
  
  func generateExpression() -> (String, Int) {
    let number1 = Int.random(in: 1...99)
    let number2 = Int.random(in: 1...99)
    let ans = number1 + number2
    let newExpression: String = "\(number1) + \(number2)"
    return (newExpression, ans)
  }
  
  private func changeLabelY(by y: CGFloat) {
    expressionLabel.frame.origin.y += y
  }

  @IBAction func didTapSubmitButton(_ sender: Any) {
    
    defer {
      answerTextField.text = ""
    }
    
    let submittedAnswer = Int(answerTextField.text!)
    if submittedAnswer == answer {
      score += 1
      scoreLabel.text = "SCORE: \(score)"
      newRound()
      
    }
  }
}

