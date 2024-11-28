import Foundation
import CoreData


extension MotivateText {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MotivateText> {
        return NSFetchRequest<MotivateText>(entityName: "MotivateText")
    }

    @NSManaged public var text: String

}

extension MotivateText : Identifiable {

}
