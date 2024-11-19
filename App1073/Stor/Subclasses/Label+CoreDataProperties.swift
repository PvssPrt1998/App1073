import Foundation
import CoreData


extension LabelCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LabelCD> {
        return NSFetchRequest<LabelCD>(entityName: "LabelCD")
    }

    @NSManaged public var color: [Double]
    @NSManaged public var name: String
    @NSManaged public var id: Int32

}

extension LabelCD : Identifiable {

}
