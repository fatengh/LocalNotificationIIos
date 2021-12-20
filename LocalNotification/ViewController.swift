//
//  ViewController.swift
//  LocalNotification
//
//  Created by admin on 20/12/2021.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource{
    
    
      @IBOutlet weak var totalTime: UILabel!
      @IBOutlet weak var time: UILabel!
      @IBOutlet weak var minTimer: UILabel!
      @IBOutlet weak var minPicker: UIPickerView!
      @IBOutlet weak var workunt: UILabel!
      @IBOutlet weak var timerTble: UITableView!
      @IBOutlet weak var starterButton: UIButton!
    

    let mins = ["5 Minute", "10 Minute", "20 Minute", "30 Minute"]
    var timerTable: [String] = []
    var inedxOfMin = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstview()
               }


    func showesTable(){
        
          totalTime.isHidden = true
          minTimer.isHidden = true
          minPicker.isHidden = true
          workunt.isHidden = true
          time.isHidden = true
          starterButton.isHidden = true
          timerTble.isHidden = false
      }
    func hiddenTable(){
        
          totalTime.isHidden = false
          minTimer.isHidden = false
          minPicker.isHidden = false
          workunt.isHidden = false
          time.isHidden = false
          starterButton.isHidden = false
          timerTble.isHidden = true
      }
    
    func firstview (){
        totalTime.text = "Total Time :"
        time.text = "0 hours , 0 min"
        minTimer.text = ""
        workunt.text = ""
        minPicker.dataSource = self
        minPicker.delegate = self
        timerTble.dataSource = self
        timerTble.isHidden = true
        
    }
    
    func lebelChange(time choosenTime: String ,timer  s : String ){
        
        totalTime.text = "Total Time: \(choosenTime)"
        time.text = "0 hours, \(choosenTime) min"
        minTimer.text = "\(choosenTime) Minute Timer Set"
        workunt.text = "Work until: \(s)"
        
    }
      
      @IBAction func startTimer(_ sender: Any) {
          
          var timer = 5
          switch(inedxOfMin){
          case 0: timer = 5
          case 1: timer = 10
          case 2: timer = 20
          case 3: timer = 30
          default:
              timer = 0
          }
          
          let formated = DateFormatter()
          formated.dateFormat = "hh:mm a"
          let dd = formated.string(from: getDate(min:timer))
          
          lebelChange(time: String(timer), timer: dd)
          let item = "\(formated.string(from: getDate(min:0))) - \(formated.string(from: getDate(min:timer))), \(timer) minute timer"
          timerTable.append(item)
          
          timerTble.reloadData()
          
          let notiDailog = UIAlertController(title: "\(timer) min countdown", message: "After \(timer) Mins  you will be notified.\nTurn your ringer on", preferredStyle: .alert)
          notiDailog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          present(notiDailog, animated: true, completion: nil)
          var temp = timer * 60
          Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
              if temp > 0{
                  temp -= 1
              }
              else{
                  self.lebelChange(time: "0", timer: "")
                  Timer.invalidate()
                  }
              }
          
          
      }
      
      func getDate(min: Int) -> Date{
          return Date().addingTimeInterval(Double(min) * 60.0)
      }
      
      
      @IBAction func showList(_ sender: UIButton) {
          showesTable()
      }
      
      
      @IBAction func addNewDay(_ sender: UIButton) {
          hiddenTable()
          let notiDailog = UIAlertController(title: "Are you sure to start new day?", message: "", preferredStyle: .alert)
          
          notiDailog.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
          notiDailog.addAction(UIAlertAction(title: "New Day", style: .default, handler: { [self] (action) -> Void in
              lebelChange(time: "0", timer: "")
              timerTable.removeAll()
              timerTble.reloadData()
          }))
          present(notiDailog, animated: true, completion: nil)
      }
      
      
      @IBAction func restartTimer(_ sender: UIButton) {
          if timerTble.isHidden == true && totalTime.text != "Total Time:"{
              let notiDailog = UIAlertController(title: "Cancel current timer?", message: "", preferredStyle: .alert)
              
              notiDailog.addAction( UIAlertAction(title: "Cancel", style: .default, handler: nil))
              let yes = UIAlertAction(title: "Yes", style: .default, handler: { [self] (action) -> Void in
                  lebelChange(time: "0", timer: "")
                  timerTable.append("CANCELED")
                  timerTble.reloadData()
              })
              yes.setValue(UIColor.red, forKey: "titleTextColor")
              notiDailog.addAction(yes)
              present(notiDailog, animated: true, completion: nil)
          }
          else{
           hiddenTable()
              
          }
      }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inedxOfMin = row
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(string: mins[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = timerTable[indexPath.row]
        return cell
    }
  }



 




