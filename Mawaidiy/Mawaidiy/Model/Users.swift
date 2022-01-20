//
//  UsersViewController.swift
//  Mawaidiy
//
//  Created by Sahab Alharbi on 30/05/1443 AH.
//

import UIKit


struct Users {
    var name : String
    var email : String
    var age : String
    var idnumber : String
    var phoneN : String
}
struct Mawid {
    var id : String
    var clinicName : String
    var patientName : String
    var description : String
    var time : String
    var place : String
}
struct Events {
    var id : String
    var eventName : String
    var startDate: Date
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: startDate)
    }
    var endDate : Date
    var datestring: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: startDate)
    }
    var notes : String
}

