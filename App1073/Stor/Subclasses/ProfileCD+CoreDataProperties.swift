import Foundation
import CoreData


extension ProfileCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileCD> {
        return NSFetchRequest<ProfileCD>(entityName: "ProfileCD")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String
    @NSManaged public var age: String
    @NSManaged public var target: String

}

extension ProfileCD : Identifiable {

}
