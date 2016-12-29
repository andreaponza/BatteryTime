import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var statusItemMenu: NSMenuItem!
    @IBOutlet weak var statusSourceMenu: NSMenuItem!
    @IBOutlet weak var percentageMenu: NSMenuItem!

    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    func update (){
        let battController = BatteryTimeController()
        var status = battController.status()
        
        statusItem.title = status[0]
        statusItem.menu = statusMenu
        statusItemMenu.title = status[1]
        statusSourceMenu.title = status[3]
        percentageMenu.title = status[2]
        
        print("updating")
    }
}

