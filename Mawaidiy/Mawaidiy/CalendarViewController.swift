//
//  CalendarViewController.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 29/05/1443 AH.
//

import UIKit
import EventKit
import EventKitUI
import Firebase

class CalendarViewController: UIViewController,EKEventEditViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        
        firestore.collection("Events").document().setData(
            [
                "event Name" : self.newEvent?.title! ,
                "start date" : self.newEvent?.startDate!.formatted() ,
                "end date" : self.newEvent?.endDate!.formatted() ,
                "notes" : self.newEvent?.notes! ,
                "userid" : self.user!
           
            

         ]
        )
        { error in
            
            if error == nil {
                print("You have successfully make a new event")
                
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
            } else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    
    controller.dismiss(animated: true, completion: nil)
}
    
    
 
    
   
    
    
    let firestore = Firestore.firestore()
    let user = Auth.auth().currentUser?.uid
    
    
    @IBOutlet weak var eventCV: UICollectionView!
    let eventStore = EKEventStore()
    var calendars: [EKCalendar]?
    var newEvent:EKEvent?
    var events = [Events]()

//    let calendars = eventStore.calendars(for: .event)
    override func viewDidLoad() {
        super.viewDidLoad()
        eventCV.dataSource = self
        eventCV.delegate = self
        loadEvents()
    }
    
    
    
    
    
    

  @IBAction func addEvent(_ sender: Any) {
   eventStore.requestAccess(to: .event) { [weak self] success, error in
       if success, error == nil {
           
          
    
           DispatchQueue.global(qos: .userInteractive).sync {
               DispatchQueue.main.async {
                   var date = Date()
                   guard let store = self?.eventStore else { return }
                   self?.newEvent = EKEvent(eventStore: store)
//                   self?.newEvent?.title = ""
//                   self?.newEvent?.startDate = Date()
//                   self?.newEvent?.endDate = Date()
                                      let othervc = EKEventEditViewController()
                                      othervc.eventStore = store
                   othervc.event = self?.newEvent
                   othervc.editViewDelegate = self
                   
                   othervc.dismiss(animated: true, completion: nil)
//                   print("_____________")
//                   print("newEvent")
////                   print(newEvent)
//                   print("othervc")
//                   print(othervc)
//                   print("_____________")
                                      self?.present(othervc, animated: true, completion: nil)
                   
                   date = Date.now
                   UserDefaults.standard.set(date, forKey: "Calender")
                   let calender = UserDefaults.standard.object(forKey: "Calender")
                   
                   print(calender)
                   }
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
    func loadEvents() {
        self.firestore.collection("Events")
            .whereField("userid", isEqualTo: self.user as Any)
            .getDocuments(
                completion: {
                    (qurySnapShot, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        for document in qurySnapShot!.documents {
                            let data = document.data()
                            
                            self.events.append(Events(eventName: data["event Name"] as! String, startDate: (data["start date"]as? Timestamp)?.dateValue() ?? Date(), endDate: (data["end date"]as? Timestamp)?.dateValue() ?? Date(), notes: data["notes"] as! String))
                            
                        }
                    }
                    self.eventCV.reloadData()
                }
            )
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

//extension CalendarViewController {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        events.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tvcell") as! EventTableViewCell
//        cell.eventName.text = events[indexPath.row].eventName
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selected = events[indexPath.row]
//        let vc = storyboard?.instantiateViewController(withIdentifier: "eventdetails") as! EventDetails
//        vc.events = selected
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//}

extension CalendarViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvcell", for: indexPath) as! EventCollectionViewCell
        cell.layer.cornerRadius = 10
        
        cell.eventName.text = events[indexPath.row].eventName
        cell.date.text = events[indexPath.row].dateString

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = events[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "eventdetails") as! EventDetails
        vc.events = selected
        navigationController?.pushViewController(vc, animated: true)
    }
    
   

}
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
