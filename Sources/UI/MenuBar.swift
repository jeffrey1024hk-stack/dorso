import AppKit
import SwiftUI

@MainActor
public class MenuBarManager: NSObject {
    // Public statusItem for popup window anchoring in AppDelegate
    public var statusItem: NSStatusItem!
    
    // Callback closures expected by AppDelegate
    public var onToggleEnabled: (() -> Void)?
    public var onOpenSettings: (() -> Void)?
    public var onOpenSupport: (() -> Void)?
    public var onShowAnalytics: (() -> Void)?
    public var onShowSettings: (() -> Void)?
    public var onShowSupport: (() -> Void)?
    public var onRecalibrate: (() -> Void)?
    public var onTogglePause: (() -> Void)?
    public var onCheckForUpdates: (() -> Void)?
    public var onQuit: (() -> Void)?
    
    public override init() {
        super.init()
        setupMenuBar()
    }
    
    /// Setup hook called explicitly by AppDelegate
    public func setup() {
        if statusItem == nil {
            setupMenuBar()
        }
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
        
        // Dashboard & Settings
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
        
        // Check for Updates
        let updateItem = NSMenuItem(
            title: "Check for Updates...",
            action: #selector(handleCheckForUpdates),
            keyEquivalent: ""
        )
        updateItem.target = self
        menu.addItem(updateItem)
        
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
        onOpenSettings?()
        onShowSettings?()
        onShowAnalytics?()
    }
    
    @objc private func handleRecalibrate() {
        if let onRecalibrate = onRecalibrate {
            onRecalibrate()
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("RecalibratePosture"), object: nil)
        }
    }
    
    @objc private func handleCheckForUpdates() {
        onCheckForUpdates?()
    }
    
    @objc private func handleQuit() {
        if let onQuit = onQuit {
            onQuit()
        } else {
            NSApplication.shared.terminate(nil)
        }
    }
    
    // Helper hooks called by AppDelegate
    public func updateShortcut(enabled: Bool, shortcut: Any? = nil) {
        // Dynamic shortcut binding
    }
    
    public func updateEnabledState(_ isEnabled: Bool) {
        // Dynamic enable/disable state update
    }
    
    public func updateRecalibrateEnabled(_ canRecalibrate: Bool) {
        // Dynamic recalibrate menu item state update
    }
    
    public func updateStatus(text: String? = nil, icon: Any? = nil) {
        // Dynamic text and icon update
    }
    
    public func updateStatus(isSlouching: Bool = false) {
        // Dynamic state update hook
    }
    
    public func updateStatus(isSlouching: Bool = false, isPaused: Bool = false) {
        // Dynamic state update hook fallback
    }
}