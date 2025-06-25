import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate, NSWindowDelegate {
  private var statusBarItem: NSStatusItem?
  private var menuBarTimer: Timer?
  private var pauseResumeMenuItem: NSMenuItem?
  private var isTimerRunning = false
  private var isTimerPaused = false
  private var nativeTimer: Timer?
  private var currentRemainingSeconds = 0
  private var currentSessionType = "focus"
  
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return false // Keep app running when window is closed
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
              // Set window size and properties
    if let window = mainFlutterWindow {
      window.setContentSize(NSSize(width: 400, height: 820))
      window.minSize = NSSize(width: 400, height: 820)
      window.maxSize = NSSize(width: 400, height: 820)
      window.center()
      window.isRestorable = true
      window.title = "Focus Timer"
      
      // Hide standard title bar and create custom one
      window.titlebarAppearsTransparent = true
      window.titleVisibility = .hidden
      window.styleMask.insert(.fullSizeContentView)
      // Keep close button but hide other standard buttons
      window.standardWindowButton(.miniaturizeButton)?.isHidden = true
      window.standardWindowButton(.zoomButton)?.isHidden = true
      
      // Set up window delegate for close animation
      window.delegate = self
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
        
      case "startNativeTimer":
        if let args = call.arguments as? [String: Any],
           let remainingSeconds = args["remainingSeconds"] as? Int,
           let sessionType = args["sessionType"] as? String {
          self.startNativeTimer(remainingSeconds: remainingSeconds, sessionType: sessionType)
          result(nil)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "remainingSeconds and sessionType required", details: nil))
        }
        
      case "stopNativeTimer":
        self.stopNativeTimer()
        result(nil)
        
      case "updateNativeTimer":
        if let args = call.arguments as? [String: Any],
           let remainingSeconds = args["remainingSeconds"] as? Int,
           let sessionType = args["sessionType"] as? String {
          self.updateNativeTimer(remainingSeconds: remainingSeconds, sessionType: sessionType)
          result(nil)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "remainingSeconds and sessionType required", details: nil))
        }
        
      case "showMainWindow":
        self.showWindowOnCurrentDesktop()
        result(nil)
        
      case "hideWindow":
        if let window = self.mainFlutterWindow {
          self.hideWindowWithAnimation(window)
          result(nil)
        } else {
          result(FlutterError(code: "NO_WINDOW", message: "Main window not found", details: nil))
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
    if let window = mainFlutterWindow, window.isVisible {
      // If window is visible, hide it with animation
      hideWindowWithAnimation(window)
    } else {
      // If window is hidden, show it on current active desktop
      showWindowOnCurrentDesktop()
    }
  }
  
  private func showWindowOnCurrentDesktop() {
    NSApp.activate(ignoringOtherApps: true)
    if let window = mainFlutterWindow {
      // Temporarily allow window to appear on all spaces
      window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
      
      // Position window on the current active screen
      positionWindowOnActiveScreen(window)
      
      // Force show on current space
      window.orderFrontRegardless()
      window.makeKeyAndOrderFront(nil)
      
      // Show window with animation
      showWindowWithAnimation(window)
      
      // Reset collection behavior after a short delay
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        window.collectionBehavior = [.fullScreenAuxiliary]
      }
      
      print("Forced window to appear on current desktop space")
    }
  }
  
  @objc private func showMainWindow() {
    NSApp.activate(ignoringOtherApps: true)
    if let window = mainFlutterWindow {
      // Force window to appear on current active space/desktop
      window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
      
      // Position window on the current active screen
      positionWindowOnActiveScreen(window)
      
      // Make sure window appears on current space
      window.orderFrontRegardless()
      
      // Show window with animation
      showWindowWithAnimation(window)
      
      // Reset collection behavior after showing
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        window.collectionBehavior = [.fullScreenAuxiliary]
      }
    }
  }
  
  @objc private func quitApp() {
    NSApp.terminate(nil)
  }
  
  @objc private func pauseResumeTimer() {
    // Send command back to Flutter
    if let controller = mainFlutterWindow?.contentViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(name: "focus_timer/macos", binaryMessenger: controller.engine.binaryMessenger)
      
      if !isTimerRunning {
        // Timer is idle - start it
        channel.invokeMethod("startTimer", arguments: nil)
      } else if isTimerPaused {
        // Timer is paused - resume it
        channel.invokeMethod("resumeTimer", arguments: nil)
      } else {
        // Timer is running - pause it
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
      
      // Update menu item title based on exact state
      if !isRunning {
        // Timer is idle - show start option
        self.pauseResumeMenuItem?.title = "Start Timer"
      } else if isPaused {
        // Timer is paused - show resume option
        self.pauseResumeMenuItem?.title = "Resume Timer"
      } else {
        // Timer is running - show pause option
        self.pauseResumeMenuItem?.title = "Pause Timer"
      }
    }
  }
  
  // MARK: - Native Timer Methods
  
  private func startNativeTimer(remainingSeconds: Int, sessionType: String) {
    stopNativeTimer() // Stop any existing timer
    
    currentRemainingSeconds = remainingSeconds
    currentSessionType = sessionType
    
    nativeTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
      self?.handleNativeTimerTick()
    }
    
    // Update display immediately
    updateNativeDisplay()
  }
  
  private func stopNativeTimer() {
    nativeTimer?.invalidate()
    nativeTimer = nil
  }
  
  private func updateNativeTimer(remainingSeconds: Int, sessionType: String) {
    currentRemainingSeconds = remainingSeconds
    currentSessionType = sessionType
    updateNativeDisplay()
  }
  
  private func handleNativeTimerTick() {
    guard currentRemainingSeconds > 0 else {
      stopNativeTimer()
      // Update menu state when timer stops
      updateMenuItems(isRunning: false, isPaused: false)
      return
    }
    
    currentRemainingSeconds -= 1
    updateNativeDisplay()
    
    if currentRemainingSeconds <= 0 {
      stopNativeTimer()
      // Update menu state to show timer is not running
      updateMenuItems(isRunning: false, isPaused: false)
      
      // Notify Flutter that timer completed
      if let controller = mainFlutterWindow?.contentViewController as? FlutterViewController {
        let channel = FlutterMethodChannel(name: "focus_timer/macos", binaryMessenger: controller.engine.binaryMessenger)
        channel.invokeMethod("nativeTimerCompleted", arguments: nil)
      }
    }
  }
  
  private func updateNativeDisplay() {
    let minutes = currentRemainingSeconds / 60
    let seconds = currentRemainingSeconds % 60
    let timeString = String(format: "%02d:%02d", minutes, seconds)
    
    let emoji = getEmojiForSessionType(currentSessionType)
    
    DispatchQueue.main.async {
      // Update dock badge
      NSApp.dockTile.badgeLabel = timeString
      
      // Update menu bar
      if let button = self.statusBarItem?.button {
        button.title = "\(emoji) \(timeString)"
      }
    }
  }
  
  private func getEmojiForSessionType(_ sessionType: String) -> String {
    switch sessionType.lowercased() {
    case "focus":
      return "🍅"
    case "shortbreak":
      return "☕"
    case "longbreak":
      return "🌱"
    default:
      return "🍅"
    }
  }
  
  // MARK: - Window Positioning and Animation
  
  private func positionWindowOnActiveScreen(_ window: NSWindow) {
    // Get the current active screen using multiple methods for reliability
    var targetScreen: NSScreen?
    
    // Method 1: Try to get screen with mouse cursor
    let mouseLocation = NSEvent.mouseLocation
    for screen in NSScreen.screens {
      if screen.frame.contains(mouseLocation) {
        targetScreen = screen
        break
      }
    }
    
    // Method 2: If mouse method failed, try to get screen with key window
    if targetScreen == nil {
      if let keyWindow = NSApp.keyWindow {
        targetScreen = keyWindow.screen
      }
    }
    
    // Method 3: If still no screen, use screen with menu bar
    if targetScreen == nil {
      targetScreen = NSScreen.screens.first { $0.frame.origin.y == 0 }
    }
    
    // Final fallback: main screen
    guard let screen = targetScreen ?? NSScreen.main else { return }
    
    let screenFrame = screen.visibleFrame
    let windowSize = window.frame.size
    
    // Try to get status bar button position if it's on this screen
    var buttonFrame: NSRect?
    if let button = statusBarItem?.button,
       let buttonWindow = button.window,
       buttonWindow.screen == screen {
      buttonFrame = button.convert(button.bounds, to: nil)
      buttonFrame = buttonWindow.convertToScreen(buttonFrame!)
    }
    
    // Position window at right edge of screen, at the very top (under menu bar)
    let rightX = screenFrame.maxX - windowSize.width // No margin from right edge
    var topY = screenFrame.maxY - windowSize.height // At the very top of visible area
    
    // Debug info
    print("Screen frame: \(screenFrame)")
    print("Window size: \(windowSize)")
    print("Calculated position: rightX=\(rightX), topY=\(topY)")
    
    // If status bar button is on this screen, try to position relative to it
    if let buttonRect = buttonFrame {
      print("Button frame: \(buttonRect)")
      // Position window right at the top of screen, aligned with button
      topY = screenFrame.maxY - windowSize.height // Keep at very top
      
      // Try to align window to end near the button
      let buttonCenterX = buttonRect.midX
      let windowX = buttonCenterX - windowSize.width / 2
      
      // Check if button-aligned position fits on screen
      if windowX >= screenFrame.minX && windowX + windowSize.width <= screenFrame.maxX {
        let finalX = windowX
        let finalY = topY
        window.setFrameOrigin(NSPoint(x: finalX, y: finalY))
        print("Positioned window centered on status bar button on screen: \(screen.localizedName) at (\(finalX), \(finalY))")
        return
      }
    }
    
    // Default positioning: right edge of screen, very top
    let finalX = rightX
    let finalY = topY
    
    // Position the window
    window.setFrameOrigin(NSPoint(x: finalX, y: finalY))
    
    print("Positioned window at right edge and top of screen: \(screen.localizedName) at (\(finalX), \(finalY))")
  }
  
  private func positionWindowOnMenuScreen(_ window: NSWindow) {
    // Get the screen where the mouse cursor is currently located (active screen)
    let mouseLocation = NSEvent.mouseLocation
    var targetScreen: NSScreen?
    
    // Find the screen that contains the mouse cursor
    for screen in NSScreen.screens {
      if screen.frame.contains(mouseLocation) {
        targetScreen = screen
        break
      }
    }
    
    // Fallback to main screen if mouse position not found
    guard let screen = targetScreen ?? NSScreen.main else { return }
    
    let screenFrame = screen.visibleFrame
    let windowSize = window.frame.size
    
    // Try to get status bar button position on the target screen
    var buttonFrame: NSRect?
    if let button = statusBarItem?.button,
       let buttonWindow = button.window,
       buttonWindow.screen == screen {
      // Status bar is on the same screen as mouse cursor
      buttonFrame = button.convert(button.bounds, to: nil)
      buttonFrame = buttonWindow.convertToScreen(buttonFrame!)
    }
    
    // Position window under menu bar, centered horizontally on screen
    let centerX = screenFrame.midX - windowSize.width / 2
    var topY = screenFrame.maxY - windowSize.height - 10 // 10px below menu bar
    
    // If we have button position on this screen, position under the button
    if let buttonRect = buttonFrame {
      topY = buttonRect.minY - windowSize.height - 10 // 10px below button
    }
    
    // Ensure window doesn't go off screen
    let finalX = max(screenFrame.minX + 10, min(centerX, screenFrame.maxX - windowSize.width - 10))
    let finalY = max(screenFrame.minY + 10, topY)
    
    // Position the window
    window.setFrameOrigin(NSPoint(x: finalX, y: finalY))
  }
  
    private func showWindowWithAnimation(_ window: NSWindow) {
    // Start with window at smaller height (dropdown effect) and transparent
    let originalFrame = window.frame
    let originalAlpha = window.alphaValue
    
    // Set initial animation state - start from top with smaller height
    window.alphaValue = 0.0
    let initialFrame = NSRect(
      x: originalFrame.origin.x,
      y: originalFrame.origin.y + originalFrame.size.height * 0.8, // Start higher
      width: originalFrame.size.width,
      height: originalFrame.size.height * 0.2 // Start with small height
    )
    window.setFrame(initialFrame, display: false)
    
    // Make window visible on current space
    window.makeKeyAndOrderFront(nil)
    
    // Ensure window is on current desktop space
    window.orderFrontRegardless()
    
    // Animate to final state with dropdown effect
    NSAnimationContext.runAnimationGroup({ context in
      context.duration = 0.25
      context.timingFunction = CAMediaTimingFunction(name: .easeOut)
      
      window.animator().alphaValue = originalAlpha
      window.animator().setFrame(originalFrame, display: true)
    }, completionHandler: {
      // Animation completed - make sure window stays on current space
      window.makeKeyAndOrderFront(nil)
    })
  }
  
  // MARK: - NSWindowDelegate
  
  func windowShouldClose(_ sender: NSWindow) -> Bool {
    // Don't close immediately, animate first
    hideWindowWithAnimation(sender)
    return false
  }
  
  private func hideWindowWithAnimation(_ window: NSWindow) {
    let originalFrame = window.frame
    
    NSAnimationContext.runAnimationGroup({ context in
      context.duration = 0.15
      context.timingFunction = CAMediaTimingFunction(name: .easeIn)
      
      // Animate to collapse upward (reverse dropdown) and fade out
      window.animator().alphaValue = 0.0
      window.animator().setFrame(NSRect(
        x: originalFrame.origin.x,
        y: originalFrame.origin.y + originalFrame.size.height * 0.8, // Collapse upward
        width: originalFrame.size.width,
        height: originalFrame.size.height * 0.2 // Shrink height
      ), display: true)
    }, completionHandler: {
      // Hide window after animation
      window.orderOut(nil)
      
      // Reset window properties for next show
      window.alphaValue = 1.0
      window.setFrame(originalFrame, display: false)
    })
  }
}
