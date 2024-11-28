import SwiftUI
import CoreData
import Foundation

final class DataManager {
    
    private let modelName = "DataModel"
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
    
    func saveStatus(_ status: Status) {
        guard let colorComponents = UIColor(status.color).cgColor.components else { return }
        let colorData = colorComponents.map({Double($0)})
        let statusCD = StatusCD(context: coreDataStack.managedContext)
        statusCD.id = Int32(status.id)
        statusCD.name = status.name
        statusCD.color = colorData
        coreDataStack.saveContext()
    }
    
    func fetchStatus() throws -> Array<Status> {
        var array: Array<Status> = []
        let statusesCD = try coreDataStack.managedContext.fetch(StatusCD.fetchRequest())
        statusesCD.forEach { scd in
            array.append(Status(id: Int(scd.id), name: scd.name, color: doubleToColor(dColor: scd.color)))
        }
        return array
    }
    
    func fetchLabel() throws -> Array<Label> {
        var array: Array<Label> = []
        let labelsCD = try coreDataStack.managedContext.fetch(LabelCD.fetchRequest())
        labelsCD.forEach { lcd in
            array.append(Label(id: Int(lcd.id), name: lcd.name, color: doubleToColor(dColor: lcd.color)))
        }
        return array
    }
    
    func saveLabel(_ label: Label) {
        guard let colorComponents = UIColor(label.color).cgColor.components else { return }
        let colorData = colorComponents.map({Double($0)})
        let labelCD = LabelCD(context: coreDataStack.managedContext)
        labelCD.id = Int32(label.id)
        labelCD.name = label.name
        labelCD.color = colorData
        coreDataStack.saveContext()
    }
    
    func saveTarget(_ target: Target) {
        let targetCD = TargetCD(context: coreDataStack.managedContext)
        targetCD.uuid = target.uuid
        targetCD.name = target.name
        targetCD.startDate = target.startDate
        targetCD.endDate = target.endDate
        targetCD.descr = target.description
        targetCD.statusId = Int32(target.status.id)
        targetCD.labelId = Int32(target.label.id)
        coreDataStack.saveContext()
    }
    
    func editTarget(_ target: Target) {
        do {
            let targetsCD = try coreDataStack.managedContext.fetch(TargetCD.fetchRequest())
            targetsCD.forEach { targetCD in
                if targetCD.uuid == target.uuid {
                    targetCD.name = target.name
                    targetCD.startDate = target.startDate
                    targetCD.endDate = target.endDate
                    targetCD.descr = target.description
                    targetCD.statusId = Int32(target.status.id)
                    targetCD.labelId = Int32(target.label.id)
                }
            }
            
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchTargets() throws -> Array<TargetCD> {
        try coreDataStack.managedContext.fetch(TargetCD.fetchRequest())
    }
    
    private func doubleToColor(dColor: [Double]) -> Color {
        Color(red: dColor[0], green: dColor[1], blue: dColor[2], opacity: dColor[3])
    }
    
    func saveOrEdit(_ motivate: Motivate) {
        do {
            let motivatesCD = try coreDataStack.managedContext.fetch(MotivateCD.fetchRequest())
            var founded = false
            motivatesCD.forEach { mcd in
                if mcd.mId == motivate.id {
                    founded = true
                    motivatesCD[0].favorite = motivate.favorite
                    motivatesCD[0].date = motivate.date
                }
            }
            if !founded {
                let motivateCD = MotivateCD(context: coreDataStack.managedContext)
                motivateCD.mId = Int32(motivate.id)
                motivateCD.date = motivate.date
                motivateCD.favorite = motivate.favorite
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchMotivates() throws -> Array<MotivateCD> {
        try coreDataStack.managedContext.fetch(MotivateCD.fetchRequest())
    }
    
    func saveProfile(_ profile: Profile) {
        do {
            let expsCD = try coreDataStack.managedContext.fetch(ProfileCD.fetchRequest())
            if expsCD.count > 0 {
                //exists
                expsCD[0].image = profile.image
                expsCD[0].name = profile.name
                expsCD[0].target = profile.target
                expsCD[0].age = profile.age
            } else {
                let expCD = ProfileCD(context: coreDataStack.managedContext)
                expCD.image = profile.image
                expCD.name = profile.name
                expCD.target = profile.target
                expCD.age = profile.age
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchProfile() throws -> Profile? {
        guard let profile = try coreDataStack.managedContext.fetch(ProfileCD.fetchRequest()).first else { return nil }
        return Profile(image: profile.image, name: profile.name, age: profile.age, target: profile.target)
    }
    
    func saveIsMotivated(_ show: Bool) {
        do {
            let ids = try coreDataStack.managedContext.fetch(IsMotivated.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].isMotivated = show
            } else {
                let isMotivated = IsMotivated(context: coreDataStack.managedContext)
                isMotivated.isMotivated = show
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchIsMotivated() throws -> Bool? {
        guard let isMotivated = try coreDataStack.managedContext.fetch(IsMotivated.fetchRequest()).first else { return nil }
        return isMotivated.isMotivated
    }
    
    func fetchMotivateText() throws -> String? {
        guard let text = try coreDataStack.managedContext.fetch(MotivateText.fetchRequest()).first else { return nil }
        return text.text
    }
    
    func saveMotivateText() {
        let text = MotivateText(context: coreDataStack.managedContext)
        coreDataStack.saveContext()
    }
}

class CoreDataStack {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                return print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
