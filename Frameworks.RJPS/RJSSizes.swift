
import UIKit

/**
 * Não associar a nenhuma class! Assim estão acessiveis a partir de qualquer ponto da aplicação. 
 * Usar apenas para funcoes muito importantes!
 */

/*
 Carrier Status bar - 320x20
 UIView - 320x460
 UINavigationBar - 320x44
 UITabBar - 320x49
 UISearchBar - 320x44
 UIToolBar - 320x44
 
 Data Input:
 
 UIPickerView - 320x216
 UIDatePicker - 320x216
 UIKeyboard - 320x216
 
 Buttons:
 
 UISegmentedControl - 320x44
 UIButton xx37
 
 Fields:
 
 UITextField - xx37
 UISwitch 94x27
 UISlider - xx23
 
 Indicators:
 
 UIProgressView -xx9
 UIActivityIndicatorView - 37x37
 UIPageControl - 38x36
*/

struct RJSSizes {
    enum Screen {
        static var width: CGFloat {
            return UIScreen.mainScreen().bounds.width
        }
        static var height: CGFloat {
            return UIScreen.mainScreen().bounds.height
        }
    }
    enum UIButton {
        static var width: CGFloat {
            return UIScreen.mainScreen().bounds.width
        }
        static var height: CGFloat {
            return 23
        }
    }
    enum UIToolbar {
        static var width: CGFloat {
            return UIScreen.mainScreen().bounds.width
        }
        static var height: CGFloat {
            return 44.0
        }
    }
    enum UINavigationBar {
        static var width: CGFloat {
            return UIScreen.mainScreen().bounds.width
        }
        static var height: CGFloat {
            return 44.0
        }
    }
    enum CarrierStatusBar {
        static var width: CGFloat {
            return UIScreen.mainScreen().bounds.width
        }
        static var height: CGFloat {
            return 20.0
        }
    }
}




