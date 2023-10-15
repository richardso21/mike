//
//  mikeApp.swift
//  mike
//
//  Created by Richard So on 9/30/23.
//

import SwiftUI
import SimplyCoreAudio

let simplyCA = SimplyCoreAudio()

func initObserver(deviceName: String = "MacBook Pro Microphone") -> NSObjectProtocol {
    return NotificationCenter.default.addObserver(forName: .defaultInputDeviceChanged,
                                                           object: nil,
                                                            queue: .main) { (notification) in
        let systemMic = simplyCA.allInputDevices.filter {
            $0.name == deviceName
        }
        if (systemMic.count == 0) {return}
        systemMic[0].isDefaultInputDevice = true
    }

}

@main
struct mikeApp: App {
    @State var inputSelection: AudioDevice = simplyCA.allInputDevices.filter {$0.name == "MacBook Pro Microphone"}[0];
    @State var isEnabled : Bool = true
    @State var observer = initObserver()
    var body: some Scene {
        MenuBarExtra("mike", systemImage: isEnabled ? "headphones.circle.fill" : "headphones.circle") {
            Text("mike is " + (isEnabled ? "enabled" : "disabled"))
            Button("Toggle mike") {
                isEnabled = !isEnabled
                if (isEnabled) {
                    inputSelection.isDefaultInputDevice = true
                    observer = initObserver(deviceName: inputSelection.name)
                } else {
                    NotificationCenter.default.removeObserver(observer)
                }
            }
            Divider()
            Text("Current Default Input: " + inputSelection.name)
            Picker("Select Default Audio Input", selection: $inputSelection) {
                ForEach(simplyCA.allInputDevices, id: \.self) {
                    Text($0.name).tag($0)
                }
            }
            .onReceive([self.inputSelection].publisher.first(), perform: { (value) in
                if (isEnabled) {
                    NotificationCenter.default.removeObserver(observer)
                    observer = initObserver(deviceName: value.name)
                    value.isDefaultInputDevice = true
                }
            })
            Divider()
            Button("Quit") {
                // clean observer before quitting
                if (isEnabled) {
                    NotificationCenter.default.removeObserver(observer)
                }
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}

