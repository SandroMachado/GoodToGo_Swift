
//import UIKit

/**
 * MVVM Utilies
 */

import UIKit

struct RJSMVVMUtils
{
    
    /**
     @brief Do unit testing for this class
     @param None.
     @return Void
     */
    static func unitTests() -> Void
    {
        /*
         * http://rasic.info/bindings-generics-swift-and-mvvm/
         */
        let nameLabel = UILabel()
        let name      = Dynamic<String>("Steve")
        
        name.bindAndFire({
            nameLabel.text = $0
        })
        
        print(name.value)      // prints: Steve
        name.value = "Tim"     // prints: did set value to Tim
        print(name.value)
        print(nameLabel.text!)
        
        assert(name.value=="Tim")
        assert(name.value==nameLabel.text)
        
        /*
         * Dynamic Generic Example
         */
        let _ = Dynamic<Bool>(false)
        let var3 = Dynamic<[String]>(["Macintosh", "iPod", "iPhone"])
        
        var3.bindAndFire {
            print("First element is \($0.first)")
        }
    }
 
}

final class Dynamic<T> {
    typealias Listener = T -> Void
    private var listener: Listener?
    
    func bind(listener: Listener?) {
        listener?(value)
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}

struct Subscription<T> {
    weak var subscriber: AnyObject?
    let next: T -> Void
}

final class Observable<T> {
    private var _value: T?
    
    var value: T? {
        get { return _value }
        set {
            _value = newValue
            notifySubscribers()
        }
    }
    
    init(_ value: T?) {
        _value = value
    }
    var subscriptions = [Subscription<T>]()
    func subscribe(subscriber: AnyObject, next: T -> Void) {
        subscriptions.append(Subscription(subscriber: subscriber, next: next))
    }
    
    private func notifySubscribers() {
        subscriptions = subscriptions.flatMap(notifyAndFilterSubscription)
    }
    
    private func notifyAndFilterSubscription(subscription:Subscription<T>) -> Subscription<T>? {
        
        // Subscriber exists.
        if let _ = subscription.subscriber, let _ = _value{
            subscription.next(_value!)
            return subscription
        }
        
        // Subscriber has gone; cull this subscription.
        return nil
    }
}









