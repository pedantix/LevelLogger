# LevelLogger
Logging on the level! For Vapor projects. Logs are the key to both debugging an
application as well as monitoring it in production. However what we are
interested in during development is often times different from our production
interests. Logging by level is one way to deal with this

### The Level Logger Comparison Order
The following is just an opinion on what should be the order of leveled debugging. In the future it would probably be good to figure out a way to make this configurable.

```swift
var orderValue: Int {
    switch self {
    case.custom: return 6
    case.fatal: return 5
    case.error: return 4
    case.warning: return 3
    case.info: return 2
    case.verbose: return 1
    case.debug: return 0
    }
}
```

### Usage
Within your projects `Swift/configure.swift` make the following changes
```swift

public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
    ) throws {
    // Register providers first
    ...
    try services.register(LevelLoggerProvider()) // Required
    ...
    config.prefer(LevelLogger.self, for: Logger.self) // Required

    // The following is optional, set to debug by default
    if env.isRelease {
        services.register(LogLevel.info)
    } else {
        // optional
        services.register(LogLevel.debug) // Set your non release log level
    }
}
```

### Shameless Plug
This is another shauncodes.com endeavor.
