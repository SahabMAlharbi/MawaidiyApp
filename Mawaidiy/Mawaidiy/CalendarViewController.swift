//
//  CalendarViewController.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 29/05/1443 AH.
//

import UIKit
import EventKit
import EventKitUI

class CalendarViewController: UIViewController, EKEventViewDelegate {
    
    let store = EKEventStore()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func addEvent(_ sender: Any) {
        store.requestAccess(to: .event) { [weak self] success, error in
            if success, error == nil {
                DispatchQueue.main.async {
                    guard let store = self?.store else { return }
                    let newEvent = EKEvent(eventStore: store)
                    newEvent.title = ""
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()
//                    let othervc = EKEventEditViewController()
//                    othervc.eventStore = store
//                    othervc.event = newEvent
//                    self?.present(othervc, animated: true, completion: nil)
                    let vc = EKEventViewController()
                    vc.delegate = self
                    vc.event = newEvent
                    let nvc = UINavigationController(rootViewController: vc)
                    self?.present(nvc, animated: true, completion: nil)
                    
                }
                
            }
        }
        
    }
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
