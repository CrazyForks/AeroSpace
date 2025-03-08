import Common

protocol AbstractApp: AnyObject, Hashable, AeroAny {
    var pid: Int32 { get }
    var id: String? { get }

    @MainActor func getFocusedWindow(startup: Bool) -> Window?
    var name: String? { get }
    var execPath: String? { get }
    var bundlePath: String? { get }
    @MainActor func detectNewWindows(startup: Bool)
}

extension AbstractApp {
    func asMacApp() -> MacApp { self as! MacApp }

    func isFirefox() -> Bool {
        ["org.mozilla.firefox", "org.mozilla.firefoxdeveloperedition", "org.mozilla.nightly"].contains(id ?? "")
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.pid == rhs.pid {
            check(lhs === rhs)
            return true
        } else {
            check(lhs !== rhs)
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(pid)
    }
}

extension Window {
    var macAppUnsafe: MacApp { app.asMacApp() }
}
