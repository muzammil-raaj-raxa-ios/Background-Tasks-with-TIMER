//
//  ViewController.swift
//  Background Tasks
//
//  Created by Mag isb-10 on 19/03/2024.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var numberLabel: UILabel!
  var counter = 0
  var backgroundTask: UIBackgroundTaskIdentifier = .invalid
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(backgroundTaskExpired), name: UIApplication.didEnterBackgroundNotification, object: nil)
    
    startBackgroundTask()
    
    // Retrieve counter value from UserDefaults
    if let savedCounter = UserDefaults.standard.value(forKey: "counter") as? Int {
      counter = savedCounter
      numberLabel.text = "\(counter)"
    }
  }
  
  func startBackgroundTask() {
    backgroundTask = UIApplication.shared.beginBackgroundTask {[weak self] in
      self?.endBackgroundTask()
    }
    
    var timer = Timer()
    
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateNumber), userInfo: nil, repeats: true)
  }
  
  func endBackgroundTask() {
    UIApplication.shared.endBackgroundTask(backgroundTask)
    backgroundTask = .invalid
  }
  
  @objc func backgroundTaskExpired() {
    endBackgroundTask()
    startBackgroundTask()
  }

  @objc func updateNumber() {
    counter += 1
    numberLabel.text = "\(counter)"
    
    UserDefaults.standard.set(counter, forKey: "counter")
  }
  
  @IBAction func resetBtn(_ sender: UIButton) {
    counter = 0
    numberLabel.text = "\(counter)"
    UserDefaults.standard.set(counter, forKey: "counter")
  }
  
  
}

