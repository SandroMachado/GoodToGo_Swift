

/*!
 * @discussion <#description#>
 * @param <#param1 description#>
 * @param <#param2 description#>
 * @return <#return description#>
*/


if #available(iOS 9.0, *)
{
    self.mapView.showsCompass = true
}
else
{
    // Fallback on earlier versions
};

/*
* completion handler
*/
// Defenicao 1
func hardProcessingWithString(input: String, completion: (result: String) -> Void) {
    completion(result: "passed param: " + input)
}

// Caso de uso 1
hardProcessingWithString("123", completion: { (result) -> Void in
    print("Done")
});
