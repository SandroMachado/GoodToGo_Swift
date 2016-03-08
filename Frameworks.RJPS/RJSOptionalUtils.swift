
import UIKit

struct RJSOptionalUtils
{
    /**
     * Givem some UIView optinal element, that contain a .text property, returns the .txt property value
     */
    static func safeUIElementGetText(uiview : AnyObject?)->String
    {
        var result : String = "";
        if let txtField = uiview as? UITextField
        {
            result = ToString(txtField.text);
        }
        else if let txtView = uiview as? UITextView
        {
            result = ToString(txtView.text);
        }
        else if let label = uiview as? UILabel
        {
            result = ToString(label.text);
        }
        else
        {
            result = ToString(uiview)
        }
        result = result.trim();
        result = result.cleanString();
        if(String.isNullOrEmpty(result))
        {
            DLogWarning("Empty? \(uiview)");
        }
        return result
    }
    
    // Prevents : fatal error: unexpectedly found nil while unwrapping an Optional value
    static func safeUIElementSetValue(uiElement : AnyObject?, value:AnyObject?) -> Bool
    {
        if(!HaveValue(value))
        {
            return false
        }
        if let some = uiElement as? UILabel {
            some.text = ToString(value)
            return true
        }
        else if let some = uiElement as? UITextField {
            some.text = ToString(value)
            return true
        }
        else if let some = uiElement as? UITextView {
            some.text = ToString(value)
            return true
        }
        else if let some = uiElement as? UIImageView {
            some.image = value as? UIImage
            return true
        }
        return false
    }
}