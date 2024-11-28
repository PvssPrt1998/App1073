import Foundation
import CoreData


extension IsMotivated {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IsMotivated> {
        return NSFetchRequest<IsMotivated>(entityName: "IsMotivated")
    }

    @NSManaged public var isMotivated: Bool

}

extension IsMotivated : Identifiable {

}
