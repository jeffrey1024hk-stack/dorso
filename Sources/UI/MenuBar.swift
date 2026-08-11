import AppKit
import SwiftUI

class MenuBarManager: NSObject {
    private var statusItem: NSStatusItem!
    
    override init() {
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
            action: #selector(openDashboard),
            keyEquivalent: "d"
        )
        dashboardItem.target = self
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
    
    @objc private func openDashboard() {
        if let appDelegate = NSApp.delegate as? AppDelegate {
            appDelegate.showDashboardWindow()
        }
    }
    
    @objc private func handleRecalibrate() {
        NotificationCenter.default.post(name: NSNotification.Name("RecalibratePosture"), object: nil)
    }
    
    @objc private func handleQuit() {
        NSApplication.shared.terminate(nil)
    }
    
    // Optional status update hook if called by AppDelegate
    func updateStatus(isSlouching: Bool) {
        // Handled dynamically by state binding
    }
}