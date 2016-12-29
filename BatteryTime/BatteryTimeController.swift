import Cocoa
import Foundation


class BatteryTimeController:NSObject {
    func shell(_ args: String...) -> String {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        
        
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        
        return output
    }
    
    func status() -> Array<String>{
        let battController = BatteryTimeController()
        var batt = battController.shell("pmset", "-g", "batt", "|awk", "'{print $4 $5 $6}'", "|grep", "';'")
        
        var info = batt.characters.split{$0 == ";"}.map(String.init)
        var infoDetail = info[0].characters.split{$0 == "\n"}.map(String.init)
        let endIndex = info[2].index(info[2].startIndex, offsetBy: 15)
        
        var item = [String]()
        item.append("\(info[2].substring(to: endIndex))")//Time [0]
        item.append(info[1].capitalized)//Status info [1]
        item.append(" \(infoDetail[1].characters.split{$0 == "\t"}.map(String.init)[1])")//Percentage [2]
        item.append(" \(infoDetail[0])")//Source [3]
        return item
    }
}
