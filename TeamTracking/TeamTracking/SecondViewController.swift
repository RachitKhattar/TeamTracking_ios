//
//  SecondViewController.swift
//  TeamTracking
//
//  Created by Rachit on 20/01/16.
//
//

import UIKit

class SecondViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    let pickerData = ["Come for meeting","Let's Gather in next 15 minutes","I will be little late today","Stuck in traffic","Not coming today","Got flat tyre","Out of office"]
    
    var selectedMessage : String?
    
    @IBOutlet weak var messagesPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMessage = pickerData[row] as String
    }
    
    @IBOutlet weak var broadcastMessageButton: UIButton!
    @IBAction func broadcastButtonAction(sender: AnyObject) {
        // call to broadcast message
        
        let serviceHelper = RestServiceHelper()
        serviceHelper.broadcastMessage("Come for meeting") { (result) -> Void in
            if (result) {
                print("broadcast success")
            } else {
                print("broadcast failure")
            }
        }
        
    }
}

