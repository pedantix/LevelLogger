import XCTest
@testable import LevelLogger
import Console

final class LevelLoggerTests: XCTestCase {
    fileprivate var fakeConsole: MyFakeConsole!

    override func setUp() {
        fakeConsole = MyFakeConsole()
    }

    func testFake() throws {
        let testString = "Stuff And Things!"
        fakeConsole.output(ConsoleText(stringLiteral: testString))
        XCTAssertEqual(fakeConsole.accumulatedText, [testString])
    }


    func testLoggerSimple()  {
        let fakeConsole = MyFakeConsole()
        let myLogger = LevelLogger(console: fakeConsole)
        let testString = "Strings!!!"
        myLogger.debug(testString)
        XCTAssertTrue(fakeConsole.accumulatedText.first?.contains(testString) ?? false)
    }

    func testRestrictingDebug() {
        let fakeConsole = MyFakeConsole()
        let myLogger = LevelLogger(console: fakeConsole, minLogLevel: .verbose)
        myLogger.debug("Debug statement")
        XCTAssertTrue(fakeConsole.accumulatedText.isEmpty)
        myLogger.verbose("Verbose Statement")
        XCTAssertFalse(fakeConsole.accumulatedText.isEmpty)
    }

    func testRestrictingVerbose() {
        let fakeConsole = MyFakeConsole()
        let myLogger = LevelLogger(console: fakeConsole, minLogLevel: .info)
        myLogger.verbose("Verbose statement")
        XCTAssertTrue(fakeConsole.accumulatedText.isEmpty)
        myLogger.info("Info Statement")
        XCTAssertFalse(fakeConsole.accumulatedText.isEmpty)
    }
}


private class MyFakeConsole: Console {
    func clear(_ type: ConsoleClear) {
        XCTFail()
    }

    func output(_ text: ConsoleText, newLine: Bool) {
        accumulatedText.append("\(text)")
    }

    func input(isSecure: Bool) -> String {
        XCTFail()
        return ""
    }

    var size: (width: Int, height: Int) = (100, 100)

    func report(error: String, newLine: Bool) {
        XCTFail()
    }

    var extend: Extend = Extend(dictionaryLiteral: ("String", ""))

    var accumulatedText: [String] = []

    func output(_ text: ConsoleText) {
        accumulatedText.append("\(text)")
    }
}
