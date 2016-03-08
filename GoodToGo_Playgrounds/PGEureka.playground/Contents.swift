//: Playground - noun: a place where people can play

///////////////////////////////////////////////////////////////////////////
//                                                                       //
// To use this Playground open the file GoodToGo_Playgrounds.xcworkspace //
//                                                                       //
///////////////////////////////////////////////////////////////////////////

import UIKit
import XCPlayground
import Eureka

print ("PGEureka - \(NSDate())")

var formVC = FormViewController()

let section = Section("The Section")

section <<< TextRow() {
    $0.value = "A TextRow"
}

section <<< DateRow() {
    $0.value = NSDate()
}

formVC.form.append(section)

formVC.view.layer.cornerRadius = 50.0
formVC.view.layer.masksToBounds = true

XCPlaygroundPage.currentPage.liveView = formVC
