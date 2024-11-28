import Foundation
import SwiftUI

final class Source: ObservableObject {
    
    @AppStorage("motivateDescription") var motivateDescription = ""
    var show = false
    let dataManager = DataManager()
    
    @Published var profile: Profile?
    
    @AppStorage("firstLoad") var firstLoad = true
    
    private var statusesAvailableId: Int? {
        if let id = statuses.last?.id { return id + 1 }
        else { return nil }
    }
    private var labelsAvailableId: Int? {
        if let id = labels.last?.id { return id + 1 }
        else { return nil }
    }
    
    var targetForEdit: Target?
    
    @Published var motivates: Array<Motivate> = [
        Motivate(id: 0, favorite: false, image: "MotivateImage1", date: ""),
        Motivate(id: 1, favorite: false, image: "MotivateImage2", date: ""),
        Motivate(id: 2, favorite: false, image: "MotivateImage3", date: ""),
        Motivate(id: 3, favorite: false, image: "MotivateImage4", date: ""),
        Motivate(id: 4, favorite: false, image: "MotivateImage5", date: ""),
        Motivate(id: 5, favorite: false, image: "MotivateImage6", date: ""),
        Motivate(id: 6, favorite: false, image: "MotivateImage7", date: ""),
        Motivate(id: 7, favorite: false, image: "MotivateImage8", date: ""),
        Motivate(id: 8, favorite: false, image: "MotivateImage9", date: ""),
        Motivate(id: 9, favorite: false, image: "MotivateImage10", date: ""),
    ]
    @Published var targets: Array<Target> = []
    @Published var labels: Array<Label> = [
        Label(id: 0, name: "School", color: .red),
        Label(id: 1, name: "Job", color: .c2551320),
        Label(id: 2, name: "Family", color: .c141730),
        Label(id: 3, name: "Relationship", color: .c0122255)
    ]
    @Published var statuses: Array<Status> = [
        Status(id: 0, name: "To do", color: .red),
        Status(id: 1, name: "Doing", color: .c2551320),
        Status(id: 2, name: "Done", color: .bgMain)
    ]
    
    var loaded = false
    
    func load() {
        if let profileCD = try? dataManager.fetchProfile() {
            self.profile = profileCD
        }
        if let labelsCD = try? dataManager.fetchLabel() {
            labelsCD.forEach { lcd in
                self.labels.append(lcd)
            }
        }
        if let statusesCD = try? dataManager.fetchStatus() {
            statusesCD.forEach { scd in
                self.statuses.append(scd)
            }
        }
        if let targetsCD = try? dataManager.fetchTargets() {
            var targetsTmp: Array<Target> = []
            targetsCD.forEach { tcd in
                targetsTmp.append(Target(uuid: tcd.uuid, name: tcd.name, startDate: tcd.startDate, endDate: tcd.endDate, description: tcd.descr, status: self.statusById(Int(tcd.statusId)) ?? Status(id: 0, name: "To do", color: .red), label: self.labelsById(Int(tcd.labelId)) ?? Label(id: 0, name: "School", color: .red)))
            }
            self.targets = targetsTmp
        }
        if let motivatesCD = try? dataManager.fetchMotivates() {
            motivatesCD.forEach { mcd in
                for index in 0..<self.motivates.count {
                    if Int(mcd.mId) == motivates[index].id {
                        motivates[index].date = mcd.date
                        motivates[index].favorite = mcd.favorite
                    }
                }
            }
        }
        self.loaded = true
    }
    
    func statusById(_ id: Int) -> Status? {
        statuses.first(where: {$0.id == id})
    }
    func labelsById(_ id: Int) -> Label? {
        labels.first(where: {$0.id == id})
    }
    
    func saveProfile(image: Data?, name: String, age: String, target: String) {
        let profile = Profile(image: image, name: name, age: age, target: age)
        self.profile = profile
        dataManager.saveProfile(profile)
    }
    
    func saveTarget(name: String, startDate: String, endDate: String, description: String, status: Status, label: Label) {
        let target = Target(uuid: UUID(), name: name, startDate: startDate, endDate: endDate, description: description, status: status, label: label)
        targets.append(target)
        dataManager.saveTarget(target)
    }
    
    func saveStatus(name: String, color: Color) {
        guard let statusesAvailableId = statusesAvailableId else { return }
        let status = Status(id: statusesAvailableId, name: name, color: color)
        statuses.append(status)
        dataManager.saveStatus(status)
        
    }
    func saveLabel(name: String, color: Color) {
        guard let labelsAvailableId = labelsAvailableId else { return }
        let label = Label(id: labelsAvailableId, name: name, color: color)
        labels.append(label)
        dataManager.saveLabel(label)
    }
    
    func editTarget(name: String, startDate: String, endDate: String, description: String, status: Status, label: Label) {
        guard let index = targets.firstIndex(where: {targetForEdit?.uuid == $0.uuid}) else { return }
        let target = Target(uuid: targetForEdit?.uuid ?? UUID(), name: name, startDate: startDate, endDate: endDate, description: description, status: status, label: label)
        targets[index] = target
        dataManager.editTarget(target)
    }
    
    func motivateToggle(_ index: Int) {
        motivates[index].favorite.toggle()
        motivates[index].date = dateToString(Date())
        dataManager.saveOrEdit(motivates[index])
    }
    
    func stringToDate(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: str)
        if let date = date {
            return date
        } else { return nil }
    }
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
