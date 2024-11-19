import Foundation
import CoreData


extension TargetCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TargetCD> {
        return NSFetchRequest<TargetCD>(entityName: "TargetCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var name: String
    @NSManaged public var descr: String
    @NSManaged public var startDate: String
    @NSManaged public var endDate: String
    @NSManaged public var statusId: Int32
    @NSManaged public var labelId: Int32

}

extension TargetCD : Identifiable {

}
