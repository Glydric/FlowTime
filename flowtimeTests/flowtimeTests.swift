//
//  flowtimeTests.swift
//  flowtimeTests
//
//  Created by Leonardo Migliorelli on 31/10/22.
//
//

import XCTest
import Fundation

final class flowtimeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func AlarmTest() throws {
        alarm = Alarm(100)
        assert(condition: alarm.seconds == 100, message: "Alarm not correctly initialized with 100 seconds")

    }

    func stopWatchTest() throws {
        watch = StopWatch()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
