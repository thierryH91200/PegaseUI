//
//  PegaseUIApp.swift
//  PegaseUI
//
//  Created by Thierry hentic on 26/10/2024.
//

import SwiftUI

@main
struct PegaseUIApp: App {
    let persistenceController = PersistenceController.shared
    
    /// Legacy app delegate.
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            ContentView100()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationWillFinishLaunching(_ notification: Notification) {
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
    }
    
    func applicationShouldTerminateAfterLastWindowClosed (_ sender: NSApplication) -> Bool {
        return true
    }
    
    @IBAction func openAbout(_ sender: Any) {
        
//        if AppDelegate.tryFocusWindow(of: AboutView.self) { return }
//
//        AboutView().showWindow(width: 530, height: 220)
  }
    
    // Tries to focus a window with specified view content type.
    // - Parameter type: The type of viewContent which hosted in a window to be focused.
    // - Returns: `true` if window exist and focused, oterwise - `false`
    static func tryFocusWindow<T: View>(of type: T.Type) -> Bool {
        guard let window = NSApp.windows.filter({ ($0.contentView as? NSHostingView<T>) != nil }).first
        else { return false }
       
        window.makeKeyAndOrderFront(self)
        return true
    }

}

func localizeString(_ key: String, comment: String = "") -> String {
    if #available(macOS 12, *) {
        return String(localized: String.LocalizationValue(key))
    } else {
        return NSLocalizedString(key, comment: comment)
    }
}
