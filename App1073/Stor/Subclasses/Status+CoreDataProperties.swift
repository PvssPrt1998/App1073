import Foundation
import CoreData


extension StatusCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatusCD> {
        return NSFetchRequest<StatusCD>(entityName: "StatusCD")
    }

    @NSManaged public var color: [Double]
    @NSManaged public var name: String
    @NSManaged public var id: Int32

}

extension StatusCD : Identifiable {

}
