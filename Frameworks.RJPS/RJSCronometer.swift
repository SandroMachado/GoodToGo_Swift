
import UIKit

/**
 * Não associar a nenhuma class! Assim estão acessiveis a partir de qualquer ponto da aplicação. 
 * Usar apenas para funcoes muito importantes!
 */

//import UIKit

struct RJSCronometer
{
    static func nthPrimeNumber(var n: Int) -> Int {
        if n < 1 { return 0 } // error condition
        var prime = 2
        while (true) { // find the `nth` no matter how large `prime`
            var isPrime = true
            for (var divisor = 2; divisor <= prime/2; ++divisor)
            {
                if 0 == prime % divisor { isPrime = false; break }
            }
            if isPrime
            {
                if 0 == --n { return prime }
            }
            prime++
        }
    }
    
    /**
     * RJSCronometer.printTimeElapsedWhenRunningCode("nthPrimeNumber")
     * {
     *    print(RJSCronometer.nthPrimeNumber(10000))
     * }
     */
    static func printTimeElapsedWhenRunningCode(title:String, operation:()->()) -> Double {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for \(title): \(timeElapsed) s")
        return timeElapsed
    }
    
    static func timeElapsedInSecondsWhenRunningCode(operation:()->()) -> Double {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        return Double(timeElapsed)
    }
    
}




