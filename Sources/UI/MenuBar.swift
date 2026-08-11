import AppKit
import SwiftUI

@MainActor
public class MenuBarManager: NSObject {
    private var statusItem: NSStatusItem!
    
    // Callback closures expected by AppDelegate
    public var onShowAnalytics: (() -> Void)?
    public var onShowSettings: (() -> Void)?
    public var onShowSupport: (() -> Void)?
    public var onRecalibrate: (() -> Void)?
    public var onTogglePause: (() -> Void)?
    public var onQuit: (() -> Void)?
    
    public override init() {
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
    
    public func rebuildMenu() {
        let menu = NSMenu()
        
        // 1. Dashboard Action
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
        if let appDelegate = NSApp.delegate as? AppDelegate {
            appDelegate.showDashboardWindow()
        }
        onShowAnalytics?()
        onShowSettings?()
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
    
    public func updateStatus(isSlouching: Bool = false) {
        // Dynamic state update hook
    }
    
    public func updateStatus(isSlouching: Bool = false, isPaused: Bool = false) {
        // Dynamic state update hook fallback
    }
}