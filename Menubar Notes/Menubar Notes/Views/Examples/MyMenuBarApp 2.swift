/*import Foundation
import Cocoa
import SwiftUI
import RichTextKit

@main
struct MyMenuBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings { EmptyView() } // or your settings view
    }
}

      /* "extends" NSObject, "implements" NSApplicationDelegate */
class AppDelegate: NSObject, NSApplicationDelegate {
    
// MARK: – 💧 Create one instance of RealmManager and pass it down  ・・・・・・・・・・・・・・・
    
    
// MARK: – 💧Rest of the Initialization  ・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・・
    
    // Avoid implicitly-unwrapped optional
    private var statusItem: NSStatusItem?
    
    // NSPanel instead of NSPopover
    private lazy var panel: NSPanel = {
        // Start with a tiny rect; we'll size/position before showing
        let p = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: 510, height: 710),
            styleMask: [.nonactivatingPanel, .hudWindow, .fullSizeContentView],
            backing: .buffered,
            defer: true
        )
        p.isFloatingPanel = true
        p.hidesOnDeactivate = false
        p.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .ignoresCycle]
        p.level = .statusBar
        p.hasShadow = true
        p.isOpaque = false
        p.backgroundColor = NSColor.windowBackgroundColor
        p.titleVisibility = .hidden
        p.titlebarAppearsTransparent = true
        p.standardWindowButton(.closeButton)?.isHidden = true
        p.standardWindowButton(.miniaturizeButton)?.isHidden = true
        p.standardWindowButton(.zoomButton)?.isHidden = true
        p.becomesKeyOnlyIfNeeded = true // do not activate the app
        return p
    }()
    
    // Global/local event monitors to close the panel
    private var globalMouseMonitor: Any?
    private var localKeyMonitor: Any?
    
    // Store as NSViewController to avoid generic mismatch (NSHostingController<some View>)
    private lazy var hostingViewController: NSViewController = {
        let root = PanelContentView()
        return NSHostingController(rootView: root)
    }()
    
    /* pretend its our menubar constructor that is on autocall */
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set the activation policy to .regular to enable multiple windows
        //NSApplication.shared.setActivationPolicy(.regular)
        
        setupMenuBar()
        setupPanel()
    }
    
    /*func applicationDidHide(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }
    func applicationDidResignActive(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }
    func applicationDidBecomeActive(_ notification: Notification) {
        //NSSound(named: "Morse")?.play()
    }*/
    
    /* Setup MenuBar */
    func setupMenuBar() {
        /* Returns a newly created status item that has been allotted a specified space within the status bar. */
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem = item
        
        guard let menuButton = item.button else { return }
        
        //menuButton.image = NSImage(systemSymbolName: "4.circle", accessibilityDescription: nil)
        //menuButton.image = NSImage(systemSymbolName: "cloud.bolt.fill", accessibilityDescription: nil)
        /* systemSymbolName is taken from SF Symbols app that is available for macOS */
        menuButton.image = NSImage(named: "Statusbar-Icon")
        menuButton.image?.isTemplate = true // allow tinting/highlight
        
        menuButton.canDrawConcurrently = true
        
        // Register click action
        menuButton.action = #selector(menuButtonClicked(_:))
        menuButton.target = self
        // Dispatch click states
        menuButton.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }
}


// MARK: - Panel setup and behavior •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension AppDelegate {
    
    func setupPanel() {
        panel.contentViewController = hostingViewController
        panel.setContentSize(NSSize(width: 510, height: 710))
    }
    
    private func showPanel() {
        guard let button = statusItem?.button else { return }
        
        // Size can be dynamic; here we use the configured content size
        let panelSize = panel.contentView?.fittingSize ?? NSSize(width: 510, height: 710)
        panel.setContentSize(panelSize)
        
        // Position the panel centered under the status bar button
        let frame = frameForPanel(anchoringTo: button, size: panelSize, gap: 6)
        panel.setFrame(frame, display: false)
        
        // Show without activating the app
        panel.orderFrontRegardless()
        
        // Highlight the status bar icon while visible
        setActiveAppearance(true)
        
        // Close on click outside
        globalMouseMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown, .otherMouseDown]) { [weak self] _ in
            self?.closePanel()
        }
        // Close on ESC
        localKeyMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == 53 { // ESC
                self?.closePanel()
                return nil
            }
            return event
        }
    }
    
    private func closePanel() {
        panel.orderOut(nil)
        setActiveAppearance(false)
        
        if let gm = globalMouseMonitor {
            NSEvent.removeMonitor(gm)
            globalMouseMonitor = nil
        }
        if let lm = localKeyMonitor {
            NSEvent.removeMonitor(lm)
            localKeyMonitor = nil
        }
    }
    
    private func togglePanel() {
        if panel.isVisible {
            closePanel()
        } else {
            showPanel()
        }
    }
    
    // Compute a frame for the panel under the status item, clamped to the current screen
    private func frameForPanel(anchoringTo button: NSStatusBarButton, size: NSSize, gap: CGFloat) -> NSRect {
        guard let window = button.window else {
            // Fallback: center on main screen
            let screen = NSScreen.main?.visibleFrame ?? .zero
            let x = screen.midX - size.width / 2
            let y = screen.midY - size.height / 2
            return NSRect(x: x, y: y, width: size.width, height: size.height)
        }
        
        // Convert the button's bounds to screen coordinates
        let buttonFrameInWindow = button.convert(button.bounds, to: nil)
        let anchorFrame = window.convertToScreen(buttonFrameInWindow)
        
        // Prefer the button's screen
        let screen = window.screen ?? NSScreen.main
        let visible = screen?.visibleFrame ?? .zero
        
        // Center horizontally under the button; clamp to screen
        var x = anchorFrame.midX - size.width / 2
        x = max(visible.minX, min(x, visible.maxX - size.width))
        
        // Place just below the button
        let y = anchorFrame.minY - size.height - gap
        
        return NSRect(x: round(x), y: round(y), width: size.width, height: size.height)
    }
    
    private func setActiveAppearance(_ active: Bool) {
        statusItem?.button?.contentTintColor = active ? .controlAccentColor : nil
    }
}


// MARK: - Menu Bar action ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension AppDelegate {

    @objc func menuButtonClicked(_ sender: AnyObject?) {
        // If you want right-click to show a contextual menu, you can detect and handle it here.
        // if let event = NSApp.currentEvent, event.type == .rightMouseUp { showContextualMenu(); return }
        
        togglePanel()
    }
}
struct PanelContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Status Panel")
                .font(.headline)
            Text("Shown above fullscreen apps.")
            Button("Close") { NSApp.keyWindow?.orderOut(nil) }
        }
        .padding(16)
        .frame(width: 320, height: 220)
        .background(.regularMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.blue.opacity(0.5), lineWidth: 1) // debugging border if you want it
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
*/
