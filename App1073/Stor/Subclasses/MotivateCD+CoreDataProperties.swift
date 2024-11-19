import Foundation
import CoreData


extension MotivateCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MotivateCD> {
        return NSFetchRequest<MotivateCD>(entityName: "MotivateCD")
    }

    @NSManaged public var mId: Int32
    @NSManaged public var favorite: Bool
    @NSManaged public var date: String

}

extension MotivateCD : Identifiable {

}
