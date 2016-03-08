//
//  Swift.Lessons
//
//  Created by Ricardo Santos on 29/02/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import Foundation

struct LCodingStyle
{
    static func start () -> Void
    {
        
        dateFromString("2014-03-14")
        convertPointAt(column: 42, row: 13)
        timedAction(afterDelay: 1.0, perform: someOtherAction)
        
        let user = User()
        if user.isHappy {
            // Do something
        } else {
            // Do something else
        }
    }
}

/*
 * Naming
 */
private let maximumWidgetCount = 100

class WidgetContainer : NSObject {
    let widgetHeightPercentage = 0.85
    func WidgetContainer() -> WidgetContainer {
        
    }
}

func dateFromString(dateString: String) -> NSDate
func convertPointAt(column column: Int, row: Int) -> CGPoint
func timedAction(afterDelay delay: NSTimeInterval, perform action: SKAction) -> SKAction!



/*
 *
 */

enum Shape {
    case Rectangle
    case Square
    case Triangle
    case Circle
}

class User : NSObect {
    var isHappy: Bool
}

/* 
 * Classe's
 */

class Circle: Shape {
    var x: Int, y: Int
    var radius: Double
    var diameter: Double {
        get {
            return radius * 2
        }
        set {
            radius = newValue / 2
        }
    }
    
    init(x: Int, y: Int, radius: Double) {
        self.x = x
        self.y = y
        self.radius = radius
    }
    
    convenience init(x: Int, y: Int, diameter: Double) {
        self.init(x: x, y: y, radius: diameter / 2)
    }
    
    func describe() -> String {
        return "I am a circle at \(centerString()) with an area of \(computeArea())"
    }
    
    override func computeArea() -> Double {
        return M_PI * radius * radius
    }
    
    private func centerString() -> String {
        return "(\(x),\(y))"
    }
}

/* 
 * Protocol Conformance
 */
class MyViewcontroller: UIViewController {
    // class stuff here
}

// MARK: - UITableViewDataSource
extension MyViewcontroller: UITableViewDataSource {
    // table view data source methods
}

// MARK: - UIScrollViewDelegate
extension MyViewcontroller: UIScrollViewDelegate {
    // scroll view delegate methods
}