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
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    
    let eventStore = EKEventStore()
    var calendars: [EKCalendar]?
//    let calendars = eventStore.calendars(for: .event)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    
    

  @IBAction func addEvent(_ sender: Any) {
   eventStore.requestAccess(to: .event) { [weak self] success, error in
       if success, error == nil {
           DispatchQueue.main.async {
               guard let store = self?.eventStore else { return }
                                  let newEvent = EKEvent(eventStore: store)
                                  newEvent.title = ""
                                  newEvent.startDate = Date()
                                  newEvent.endDate = Date()
                                  let othervc = EKEventEditViewController()
                                  othervc.eventStore = store
                                  othervc.event = newEvent
                                  self?.present(othervc, animated: true, completion: nil)
               }
    
    
    
    
       }
    
    
    
    
    
    
    
    
    
    
    
//        checkStatusAndGetAllEvents()

//        let weekFromNow = Date().advanced(by: TimeInterval.week)
//
//        let predicate = eventStore.predicateForEvents(withStart: Date(), end: weekFromNow, calendars: Array(selectedCalendars))
//
//        events = eventStore.events(matching: predicate)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
//
        // Do any additional setup after loading the view.
    
    
//      private func createDate(year: Int) -> Date {
//          var components = DateComponents()
//          components.year = year
//          components.timeZone = TimeZone(secondsFromGMT: 0)
//
//          return Calendar.current.date(from: components)!
//      }
//
//
//      private func get() {
//          let calendars = eventStore.calendars(for: .event)
//
//          for calendar in calendars {
//              // This checking will remove Birthdays and Hollidays callendars
//              guard calendar.allowsContentModifications else {
//                  continue
//              }
//
//              let start = createDate(year: 2016)
//              let end = createDate(year: 2025)
//
//              print("start: (start)")
//              print("  end: (end)")
//
//              let predicate = eventStore.predicateForEvents(withStart: start, end: end, calendars: [calendar])
//
//              print("predicate: (predicate)")
//
//              let events = eventStore.events(matching: predicate)
//
//              for event in events {
//                  print("    title: (event.title!)")
//                  print("startDate: (event.startDate!)")
//                  print("  endDate: (event.endDate!)")
//              }
//          }
//      }
//
//      func checkStatusAndGetAllEvents() {
//          let currentStatus = EKEventStore.authorizationStatus(for: EKEntityType.event)
//
//          switch currentStatus {
//          case .authorized:
//              //print("authorized")
//              self.get()
//          case .notDetermined:
//              //print("notDetermined")
//              eventStore.requestAccess(to: .event) { accessGranted, error in
//                  if accessGranted {
//                      self.get()
//                  } else {
//                      print("Change Settings to Allow Access")
//                  }
//              }
//          case .restricted:
//              print("restricted")
//          case .denied:
//              print("denied")
//          }
//
//                 else{
//
//                     print("failed to save event with error : \(error) or access not granted")
//                 }
               
//
//
//                    let vc = EKEventViewController()
//                    vc.delegate = self
//
//                    vc.event = newEvent
//                    let nvc = UINavigationController(rootViewController: vc)
//                    self?.present(nvc, animated: true, completion: nil)
                    
                                
            }
        }
        
    }

    
//    func loadCalendars() {
//            self.calendars = eventStore.calendars(for: EKEntityType.event)
//       }
//    func fetchEventsFromCalendar() -> Void {
//        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
//
//        switch (status) {
//        case .notDetermined:
//            requestAccessToCalendar()
//        case .authorized:
//            self.fetchEventsFromCalendar(calendarTitle: "Calendar")
//            break
//        case .restricted, .denied: break
//
//        }
//    }
//
//    func requestAccessToCalendar() {
//
//        eventStore.requestAccess(to: EKEntityType.event) { (accessGranted, error) in
//
//            self.fetchEventsFromCalendar(calendarTitle: "Calendar")
//
//        }
//
//    }
//    func fetchEventsFromCalendar(calendarTitle: String) -> Void {
//
//        //PGAEventsCalendar
//        for calendar:EKCalendar in calendars! {
//
//            if calendar.title == calendarTitle {
//
//            let selectedCalendar = calendar
//            let startDate = NSDate(timeIntervalSinceNow: -60*60*24*180)
//            let endDate = NSDate(timeIntervalSinceNow: 60*60*24*180)
//            let predicate = eventStore.predicateForEvents(withStart: startDate as Date, end: endDate as Date, calendars: [selectedCalendar])
//            addedEvents = eventStore.events(matching: predicate) as [EKEvent]
//
//            print("addedEvents : \(addedEvents)")
//
//            }
//        }
//
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//


