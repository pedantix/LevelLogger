import Console
import Logging


// Lovingly Modifying
// https://github.com/vapor/console/blob/038e30ec9004fb1915d14d964a3facc1ec5c80f4/Sources/Console/Utilities/ConsoleLogger.swift
/// `Console` based `Logger` implementation.
public final class LevelLogger: Logger, Service {
    /// The `Console` powering this `Logger`.
    private let console: Console

    /// The Minimum Logger Level that will be printed to console
    private let minLogLevel: LogLevel

    /// Create a new `ConsoleLogger`.
    ///
    /// - parameters:
    ///     - console: `Console` to use for logging messages.
    public init(console: Console, minLogLevel: LogLevel = .debug) {
        self.console = console
        self.minLogLevel = minLogLevel
    }

    // swiftlint:disable function_parameter_count
    /// See `Logger`.
    public func log(_ string: String, at level: LogLevel, file: String, function: String, line: UInt, column: UInt) {
        guard level >= minLogLevel else { return }

        console.output(
            ConsoleText(fragments: [
                ConsoleTextFragment(string: "[ ", style: level.consoleStyle),
                ConsoleTextFragment(string: level.description, style: level.consoleStyle),
                ConsoleTextFragment(string: " ] ", style: level.consoleStyle),
                ConsoleTextFragment(string: string),
                ConsoleTextFragment(string: " (", style: .info),
                ConsoleTextFragment(string: String(file.split(separator: "/").last!), style: .info),
                ConsoleTextFragment(string: ":", style: .info),
                ConsoleTextFragment(string: line.description, style: .info),
                ConsoleTextFragment(string: ")", style: .info)
                ]
            )
        )
    }
    // swiftlint:enable function_parameter_count
}

private extension LogLevel {
    /// Converts `LogLevel` to `ConsoleStyle`.
    var consoleStyle: ConsoleStyle {
        switch self {
        case .custom, .verbose, .debug: return .plain
        case .error, .fatal: return .error
        case .info: return .info
        case .warning: return .warning
        }
    }
}

extension LogLevel: Service { }

extension LogLevel: Comparable, Equatable {
    private var orderValue: Int {
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

    public static func == (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.orderValue == rhs.orderValue
    }

    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.orderValue < rhs.orderValue
    }
}
