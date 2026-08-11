import AppKit
import SwiftUI

@MainActor
class MenuBarManager: NSObject {
    private var statusItem: NSStatusItem!
    
    // Callback closures expected by AppDelegate
    var onShowAnalytics: (() -> Void)?
    var onShowSettings: (() -> Void)?
    var onShowSupport: (() -> Void)?
    var onRecalibrate: (() -> Void)?
    var onTogglePause: (() -> Void)?
    var onQuit: (() -> Void)?
    
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
        
        // 1. Opens the new Notability SwiftUI Dashboard
        let dashboardItem = NSMenuItem(
            title: "Dashboard & Settings...",
            action: #selector(openDashboard),
            keyEquivalent: "d"
        )
        dashboardItem.target = self
        menu.addItem(dashboardItem)
        
        menu.addItem(NSMenuItem.separator())
        
        // 2. Recalibrate Action
        let recalibrateItem = NSMenuItem(
            title: "Recalibrate Posture",
            action: #selector(handleRecalibrate),
            keyEquivalent: "r"
        )
        recalibrateItem.target = self
        menu.addItem(recalibrateItem)
        
        menu.addItem(NSMenuItem.separator())
        
        // 3. Quit Action
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
        // Open the modern Dashboard UI
        if let appDelegate = NSApp.delegate as? AppDelegate {
            appDelegate.showDashboardWindow()
        }
        // Execute AppDelegate callback if set
        onShowAnalytics?()
    }
    
    @objc private func handleRecalibrate() {
        if let onRecalibrate = onRecalibrate {
            onRecalibrate()
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("RecalibratePosture"), object: nil)
        }
    }
    
    @objc private func handleQuit() {
        if let onQuit = onQuit {
            onQuit()
        } else {
            NSApplication.shared.terminate(nil)
        }
    }
    
    // Status update helper hooks called by AppDelegate
    func updateStatus(isSlouching: Bool = false) {
        // Handled dynamically by state binding
    }
    
    func updateStatus(isSlouching: Bool = false, isPaused: Bool = false) {
        // Fallback for multi-parameter status updates
    }
}