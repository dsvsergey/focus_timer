import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  private var statusBarItem: NSStatusItem?
  private var menuBarTimer: Timer?
  private var pauseResumeMenuItem: NSMenuItem?
  private var isTimerRunning = false
  private var isTimerPaused = false
  
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return false // Keep app running when window is closed
  }
  
  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
    // Set window size and properties
    if let window = mainFlutterWindow {
      window.setContentSize(NSSize(width: 400, height: 600))
      window.minSize = NSSize(width: 350, height: 550)
      window.maxSize = NSSize(width: 500, height: 700)
      window.center()
      window.isRestorable = true
      window.title = "Focus Timer"
    }
    
    let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
    
    // Set up method channel for native macOS functionality
    let macosChannel = FlutterMethodChannel(name: "focus_timer/macos", binaryMessenger: controller.engine.binaryMessenger)
    
    macosChannel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      guard let self = self else { return }
      
      switch call.method {
      case "initialize":
        self.initializeMacOSFeatures()
        result(nil)
        
      case "updateDockBadge":
        if let args = call.arguments as? [String: Any],
           let text = args["text"] as? String {
          self.updateDockBadge(text: text)
          result(nil)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Text required", details: nil))
        }
        
      case "clearDockBadge":
        self.clearDockBadge()
        result(nil)
        
      case "showMenuBarIcon":
        self.showMenuBarIcon()
        result(nil)
        
      case "hideMenuBarIcon":
        self.hideMenuBarIcon()
        result(nil)
        
              case "updateMenuBarTitle":
        if let args = call.arguments as? [String: Any],
           let title = args["title"] as? String {
          self.updateMenuBarTitle(title: title)
          result(nil)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Title required", details: nil))
        }
        
      case "updateMenuBarForPause":
        self.updateMenuBarForPause()
        result(nil)
        
      case "updateMenuBarForResume":
        self.updateMenuBarForResume()
        result(nil)
        
      case "updateMenuItems":
        if let args = call.arguments as? [String: Any],
           let isRunning = args["isRunning"] as? Bool,
           let isPaused = args["isPaused"] as? Bool {
          self.updateMenuItems(isRunning: isRunning, isPaused: isPaused)
          result(nil)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "isRunning and isPaused required", details: nil))
        }
        
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    super.applicationDidFinishLaunching(notification)
  }
  
  // MARK: - Initialization
  
  private func initializeMacOSFeatures() {
    // Set up initial macOS features
    print("macOS features initialized")
  }
  
  // MARK: - Dock Badge Methods
  
  private func updateDockBadge(text: String) {
    DispatchQueue.main.async {
      NSApp.dockTile.badgeLabel = text
    }
  }
  
  private func clearDockBadge() {
    DispatchQueue.main.async {
      NSApp.dockTile.badgeLabel = nil
    }
  }
  
  // MARK: - Menu Bar Methods
  
  private func showMenuBarIcon() {
    DispatchQueue.main.async {
      if self.statusBarItem == nil {
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = self.statusBarItem?.button {
          // Create a simple timer icon that works on macOS 10.15+
          button.title = "🍅"
          button.target = self
          button.action = #selector(self.statusBarButtonClicked)
        }
        
        self.setupMenuBarMenu()
      }
    }
  }
  
  private func hideMenuBarIcon() {
    DispatchQueue.main.async {
      if let statusBarItem = self.statusBarItem {
        NSStatusBar.system.removeStatusItem(statusBarItem)
        self.statusBarItem = nil
      }
    }
  }
  
  private func updateMenuBarTitle(title: String) {
    DispatchQueue.main.async {
      if let button = self.statusBarItem?.button {
        button.title = title
      }
    }
  }
  
  private func setupMenuBarMenu() {
    let menu = NSMenu()
    
    let showAppItem = NSMenuItem(title: "Show Focus Timer", action: #selector(showMainWindow), keyEquivalent: "")
    showAppItem.target = self
    menu.addItem(showAppItem)
    
    menu.addItem(NSMenuItem.separator())
    
    // Add pause/resume menu item
    pauseResumeMenuItem = NSMenuItem(title: "Pause Timer", action: #selector(pauseResumeTimer), keyEquivalent: "")
    pauseResumeMenuItem?.target = self
    pauseResumeMenuItem?.isEnabled = false // Initially disabled
    menu.addItem(pauseResumeMenuItem!)
    
    menu.addItem(NSMenuItem.separator())
    
    let quitItem = NSMenuItem(title: "Quit Focus Timer", action: #selector(quitApp), keyEquivalent: "q")
    quitItem.target = self
    menu.addItem(quitItem)
    
    statusBarItem?.menu = menu
  }
  
  @objc private func statusBarButtonClicked() {
    showMainWindow()
  }
  
  @objc private func showMainWindow() {
    NSApp.activate(ignoringOtherApps: true)
    if let window = mainFlutterWindow {
      window.makeKeyAndOrderFront(nil)
    }
  }
  
  @objc private func quitApp() {
    NSApp.terminate(nil)
  }
  
  @objc private func pauseResumeTimer() {
    // Send command back to Flutter
    if let controller = mainFlutterWindow?.contentViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(name: "focus_timer/macos", binaryMessenger: controller.engine.binaryMessenger)
      
      if isTimerPaused {
        channel.invokeMethod("resumeTimer", arguments: nil)
      } else {
        channel.invokeMethod("pauseTimer", arguments: nil)
      }
    }
  }
  
  // MARK: - Pause/Resume Methods
  
  private func updateMenuBarForPause() {
    DispatchQueue.main.async {
      if let button = self.statusBarItem?.button {
        button.title = "⏸️"
      }
      // Also update dock badge to show pause symbol
      NSApp.dockTile.badgeLabel = "⏸️"
      
      self.isTimerPaused = true
      self.pauseResumeMenuItem?.title = "Resume Timer"
    }
  }
  
  private func updateMenuBarForResume() {
    DispatchQueue.main.async {
      self.isTimerPaused = false
      self.pauseResumeMenuItem?.title = "Pause Timer"
      // The timer will update the title and dock badge with actual time
    }
  }
  
  private func updateMenuItems(isRunning: Bool, isPaused: Bool) {
    DispatchQueue.main.async {
      self.isTimerRunning = isRunning
      self.isTimerPaused = isPaused
      
      // Enable/disable pause button based on timer state
      self.pauseResumeMenuItem?.isEnabled = isRunning
      
      // Update menu item title
      if isPaused {
        self.pauseResumeMenuItem?.title = "Resume Timer"
      } else {
        self.pauseResumeMenuItem?.title = "Pause Timer"
      }
    }
  }
}
