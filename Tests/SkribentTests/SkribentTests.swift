import XCTest
@testable import Skribent

fileprivate extension Tag {
    static var exampleTag: Tag = {
        return Tag(name: "Example", prefix: "🧪")
    }()
}

fileprivate enum TestError: Error {
    case someError(String)
}

@available(OSX 10.12, *)
final class SkribentTests: XCTestCase {


    class SkribentPlugin: Plugin {
        var logCalled = false
        var productionMode = false

        func log(level: LogLevel, tag: Tag?, file: String, functionName: String, line: Int, production: Bool) {
            logCalled = true
            productionMode = production
        }
    }

    func testSkribentPlugin() {

        let skribent = Skribent()
        let plugin = SkribentPlugin()

        skribent.add(plugin: plugin)
        skribent.log(level: .info("Test shall be successful"))

        XCTAssertTrue(plugin.logCalled)
    }

    func testProductionModeIsChanged() {
        let skribent = Skribent()
        let plugin = SkribentPlugin()

        skribent.add(plugin: plugin)

        skribent.log(level: .info("Test shall be successful"))
        XCTAssertFalse(plugin.productionMode)

        skribent.productionMode = true
        skribent.log(level: .info("Test shall be successful"))
        XCTAssertTrue(plugin.productionMode)
    }

    func testTagIsIgnored() {
        let skribent = Skribent()
        let plugin = SkribentPlugin()

        skribent.add(plugin: plugin)
        skribent.ignore(tag: .exampleTag)

        skribent.log(level: .info("Test shall be successful"), tag: .exampleTag)

        XCTAssertFalse(plugin.logCalled)
    }
}
