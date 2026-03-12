//
//  MyMenuBarApp.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-10-05.
//

/**
 
 */

/*import AppKit
import SwiftUI

@main
struct MyMenuBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings { EmptyView() } // or your settings view
    }
}


class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var panelController: StatusPanelController!

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.title = "★"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(togglePanel(_:))
        // No need to create hosting/container here; we initialize the panel controller on demand.
    }

    @objc private func togglePanel(_ sender: Any?) {
        guard let button = statusItem.button else { return }
        if panelController == nil {
            // Initialize the panel controller with your SwiftUI content.
            panelController = StatusPanelController(rootView: PanelContentView())
        }
        panelController.toggle(relativeTo: button)
    }
}

// MARK: - StatusPanel

final class StatusPanel: NSPanel {

    init(contentViewController: NSViewController, size: NSSize = NSSize(width: 360, height: 420)) {
        super.init(
            contentRect: NSRect(origin: .zero, size: size),
            styleMask: [.nonactivatingPanel, .borderless],
            backing: .buffered,
            defer: false
        )

        self.contentViewController = contentViewController

        level = .statusBar
        isFloatingPanel = true
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .ignoresCycle, .transient]

        hidesOnDeactivate = false
        becomesKeyOnlyIfNeeded = true

        // Let SwiftUI draw the background; keep the panel transparent.
        isOpaque = false
        hasShadow = true
        backgroundColor = .clear
    }

    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { false }

    override func cancelOperation(_ sender: Any?) {
        orderOut(nil)
    }
}

// MARK: - StatusPanelController

final class StatusPanelController {

    private let popover: NSPopover

    // Generic initializer for SwiftUI content
    init<Content: View>(rootView: Content, contentSize: NSSize? = nil) {
        let popover = NSPopover()
        popover.behavior = .transient
        popover.animates = true

        let hosting = NSHostingController(rootView: rootView)
        popover.contentViewController = hosting

        if let size = contentSize {
            popover.contentSize = size
        } else {
            // Try to size to fit the SwiftUI view; fall back to a sensible default
            hosting.view.layoutSubtreeIfNeeded()
            let fitting = hosting.view.fittingSize
            if fitting.width > 0 && fitting.height > 0 {
                popover.contentSize = fitting
            } else {
                popover.contentSize = NSSize(width: 320, height: 240)
            }
        }

        self.popover = popover
    }

    // Keep a minimal AppKit-only initializer if needed
    init(contentSize: NSSize = NSSize(width: 320, height: 240)) {
        let popover = NSPopover()
        popover.behavior = .transient
        popover.animates = true
        popover.contentSize = contentSize

        // Minimal content so it compiles and shows something.
        let vc = NSViewController()
        let view = NSView(frame: NSRect(origin: .zero, size: contentSize))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor

        let label = NSTextField(labelWithString: "Hello from StatusPanelController")
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        vc.view = view
        popover.contentViewController = vc

        self.popover = popover
    }

    func toggle(relativeTo statusButton: NSStatusBarButton, preferredEdge: NSRectEdge = .minY) {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            show(relativeTo: statusButton, preferredEdge: preferredEdge)
        }
    }

    func show(relativeTo statusButton: NSStatusBarButton, preferredEdge: NSRectEdge = .minY) {
        popover.show(relativeTo: statusButton.bounds, of: statusButton, preferredEdge: preferredEdge)
    }

    func close() {
        popover.performClose(nil)
    }

    var isShown: Bool { popover.isShown }
}

// MARK: - Optional container you can use if you need AppKit overlays with SwiftUI

final class PanelContainerViewController<Content: View>: NSViewController {

    private let hosting: NSHostingController<Content>
    private let addDebugBorder: Bool

    init(rootView: Content, addDebugBorder: Bool = false) {
        self.hosting = NSHostingController(rootView: rootView)
        self.addDebugBorder = addDebugBorder
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        // Container view that we control
        self.view = NSView()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.clear.cgColor

        // Add hosting view as a child in our container
        addChild(hosting)
        let hostedView = hosting.view
        hostedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostedView)

        NSLayoutConstraint.activate([
            hostedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostedView.topAnchor.constraint(equalTo: view.topAnchor),
            hostedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        if addDebugBorder {
            let border = NSView(frame: .zero)
            border.wantsLayer = true
            border.layer?.borderColor = NSColor.systemBlue.withAlphaComponent(0.5).cgColor
            border.layer?.borderWidth = 1
            border.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(border) // Add to the container, NOT to hosting.view

            NSLayoutConstraint.activate([
                border.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                border.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                border.topAnchor.constraint(equalTo: view.topAnchor),
                border.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
}

// MARK: - Helpers / Sample Content

struct DebugBorderView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let v = NSView()
        v.wantsLayer = true
        v.layer?.borderColor = NSColor.systemBlue.withAlphaComponent(0.5).cgColor
        v.layer?.borderWidth = 1
        return v
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

struct PanelContentView: View {
    var body: some View {
        if #available(macOS 26.0, *) {
            GlassEffectContainer(spacing: 40.0) {
           
                Text("Status Panel")
                    .font(.headline)
                Text("Shown above fullscreen apps.")
                Button("Close") {
                    // Closing the popover from inside the content would require an environment callback.
                    // For now, this is a placeholder.
                    NSApp.keyWindow?.orderOut(nil)
                }
                .buttonStyle(.glass)
            
           
           
                
               
            }
            .frame(width: 320, height: 220) .glassEffect(.regular.interactive()) // An `offset` shows how Liquid Glass effects react to each other in a container.
            // Use animations and components appearing and disappearing to obtain effects that look purposeful.
            .offset(x: -40.0, y: 10.0)
        } else {
            
            VStack(spacing: 12) {
                Text("Status Panel")
                    .font(.headline)
                Text("Shown above fullscreen apps.")
                Button("Close") {
                    // Closing the popover from inside the content would require an environment callback.
                    // For now, this is a placeholder.
                    NSApp.keyWindow?.orderOut(nil)
                }
            }
            .padding(16)
            .frame(width: 320, height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        
    }
}
*/
