import Service
import Logging

public final class LevelLoggerProvider: Provider {
    public init() {}

    public func register(_ services: inout Services) throws {
        // NOTE: Override this in provider user to "ChangeLthe Level
        services.register(LogLevel.debug)
        services.register(Logger.self) { container -> LevelLogger in
            return try LevelLogger(console: container.make(), minLogLevel: container.make())
        }
    }

    /// Called before the container has fully initialized.
    public func willBoot(_ container: Container) throws -> Future<Void> {
        return .done(on: container)
    }

    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}
