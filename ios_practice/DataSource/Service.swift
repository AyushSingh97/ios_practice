///
/// Service class is responsible for providing data related to color and label from the model class.
///
/// This class has two functions getColor and getLabel. Both the functions have a similar implementation,
/// they take a parameter and a callback function.
///
/// - Parameters:
/// - colorName: A String value which can either be RED or PURPLE.
/// - text: A String value which can either be RED or PURPLE.
///
/// - callBack: A completion block that returns Model type data.
///
class Service{
    /// This function is responsible for getting a color value from the model.
    ///
    /// - Parameters:
    ///     - colorName: A String value which can either be `RED` or `PURPLE`.
    ///
    /// - callBack: A completion block that returns `Model` type data.
    ///
    func getColor(colorName:String, callBack: (Model?) -> Void) {
        if(colorName == "RED"){
            callBack(Model(color: .purple, label: "PURPLE"))
            return
        }
        callBack(Model(color: .red, label: "RED"))
        return
    }

    /// This function is responsible for getting a label value from the model.
    ///
    /// - Parameters:
    ///     - text: A String value which can either be `RED` or `PURPLE`.
    ///
    /// - callBack: A completion block that returns `Model` type data.
    ///
    func getLabel(text:String, callBack: (Model?) -> Void) {
        if(text == "RED"){
            callBack(Model(color: .purple, label: "PURPLE"))
            return
        }
        callBack(Model(color: .red, label: "RED"))
        return
    }
}
