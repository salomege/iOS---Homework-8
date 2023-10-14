

class ControlCenter: StationModule {
    var isLockedDown: Bool
    fileprivate var securityCode: String
    init(isLockedDown: Bool, securityCode: String, moduleName: String, drone: Drone?) {
        self.isLockedDown = isLockedDown
        self.securityCode = securityCode
        super.init(moduleName: moduleName, drone: drone)
    }
    func lockDown (password: String){
        if password == securityCode {
            isLockedDown = true
        }
        
    }
    func infoAboutLockDown() {
        if isLockedDown {
            print ("it's locked down")
        }else {
            print ("it's unlocked")
            
        }
    }
}

class ResearchLab: StationModule {
    var samples: [String]
    init(samples: [String], moduleName: String, drone: Drone?) {
        self.samples = samples
        super.init(moduleName: moduleName, drone: drone)
    }
    func addSamples (sample: String) {
        samples.append(sample)
    }
}

class LifeSupportSystem: StationModule {
    var OxygenLevel: Int
    init(OxygenLevel: Int, moduleName: String, drone: Drone?) {
        self.OxygenLevel = OxygenLevel
        super.init(moduleName: moduleName, drone: drone)
    }
    func OxygenLevelStatus () {
        print(OxygenLevel)
    }
}

class StationModule {
    let moduleName: String
    var drone: Drone?
    init(moduleName: String, drone: Drone? = nil) {
        self.moduleName = moduleName
        self.drone = drone
    }
    func giveTaskToDrone (task: String) {
        print (task)
    }
}

class Drone {
    var task: String?
    unowned var assignedModule: StationModule
    weak var missionControlLink: MissionControl?
    init(task: String? = nil, assignedModule: StationModule, missionControlLink: MissionControl? = nil) {
        self.task = task
        self.assignedModule = assignedModule
        self.missionControlLink = missionControlLink
    }
    func printTask() {
        if let task = task {
            print ("The task is: \(task)")
        } else {
            print ("There is no Task")
        }
    }
}
class OrbitonSpaceStation {
    var controlCenter: ControlCenter
    var researchLab: ResearchLab
    var lifeSupportSystem: LifeSupportSystem

    let controlCenterDrone: Drone
    let researchLabDrone: Drone
    let lifeSupportSystemDrone: Drone

    init(controlCenter: ControlCenter, researchLab: ResearchLab, lifeSupportSystem: LifeSupportSystem,
         controlCenterDrone: Drone, researchLabDrone: Drone, lifeSupportSystemDrone: Drone) {
        self.controlCenter = controlCenter
        self.researchLab = researchLab
        self.lifeSupportSystem = lifeSupportSystem
        self.controlCenterDrone = controlCenterDrone
        self.researchLabDrone = researchLabDrone
        self.lifeSupportSystemDrone = lifeSupportSystemDrone
    }

    func lockDownControlCenter(password: String) {
        if controlCenter.isLockedDown == false && password == controlCenter.securityCode {
            controlCenter.lockDown(password: password)
        }
    }
}
        
    

class MissionControl {
    var spaceStation: OrbitonSpaceStation?
    
    func connecToOrbitonSpaceStation(spaceStation: OrbitonSpaceStation) {
        self.spaceStation = spaceStation
    }
    func requestControlCenterStatus() {
        if let controlCenter = spaceStation?.controlCenter {
            controlCenter.infoAboutLockDown()
        }
        
    }
    func requestOxygenStatus () {
        if let lifeSupportSystem = spaceStation?.lifeSupportSystem {
            lifeSupportSystem.OxygenLevelStatus()
        }
        
    }
    func requestDroneStatus () {
        if let spaceStation = spaceStation {
            let controlCenterDrone = spaceStation.controlCenterDrone
            let researchLabDrone = spaceStation.researchLabDrone
            let lifeSupportSystemDrone = spaceStation.lifeSupportSystemDrone
        }
        
    }
    
}


let spaceStation = OrbitonSpaceStation(
    controlCenter: controlCenter,
    researchLab: researchLab,
    lifeSupportSystem: lifeSupportSystem,
    controlCenterDrone: controlCenterDrone,
    researchLabDrone: researchLabDrone,
    lifeSupportSystemDrone: lifeSupportSystemDrone
)

let missionControl = MissionControl()
missionControl.connectToOrbitonSpaceStation(spaceStation: spaceStation)

let controlCenter = ControlCenter(isLockedDown: false, securityCode: "5238", moduleName: "Control Center", drone: nil)
let researchLab = ResearchLab(samples: [], moduleName: "Research Lab", drone: nil)
let lifeSupportSystem = LifeSupportSystem(OxygenLevel: 100, moduleName: "Life Support System", drone: nil)

let controlCenterDrone = Drone(task: "perform security check", assignedModule: controlCenter)
let researchLabDrone = Drone(task: "collect samples", assignedModule: researchLab)
let lifeSupportSystemDrone = Drone(task: "control oxygen level", assignedModule: lifeSupportSystem)



missionControl.requestControlCenterStatus()

missionControl.requestOxygenStatus()

missionControl.requestDroneStatus()
