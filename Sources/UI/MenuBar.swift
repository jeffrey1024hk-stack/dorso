import AppKit
import SwiftUI

class MenuBar: NSObject {
    private var statusItem: NSStatusItem!
    private weak var appDelegate: AppDelegate?
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
        super.init()
        setupMenuBar()
    }
    
    private func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "figure.walk", accessibilityDescription: "Dorso")
        }
        
        rebuildMenu()
    }
    
    func rebuildMenu() {
        let menu = NSMenu()
        
        // Opens the new Notability SwiftUI Dashboard
        let dashboardItem = NSMenuItem(
            title: "Dashboard & Settings...",
            action: #selector(AppDelegate.showDashboardWindow),
            keyEquivalent: "d"
        )
        dashboardItem.target = appDelegate
        menu.addItem(dashboardItem)
        
        menu.addItem(NSMenuItem.separator())
        
        // Recalibrate Action
        let recalibrateItem = NSMenuItem(
            title: "Recalibrate Posture",
            action: #selector(handleRecalibrate),
            keyEquivalent: "r"
        )
        recalibrateItem.target = self
        menu.addItem(recalibrateItem)
        
        menu.addItem(NSMenuItem.separator())
        
        // Quit Action
        let quitItem = NSMenuItem(
            title: "Quit Dorso",
            action: #selector(handleQuit),
            keyEquivalent: "q"
        )
        quitItem.target = self
        menu.addItem(quitItem)
        
        statusItem.menu = menu
    }
    
    @objc private func handleRecalibrate() {
        NotificationCenter.default.post(name: NSNotification.Name("RecalibratePosture"), object: nil)
    }
    
    @objc private func handleQuit() {
        NSApplication.shared.terminate(nil)
    }
}