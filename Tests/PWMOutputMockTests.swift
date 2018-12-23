//
//  PWMOutputMockTests.swift
//  HardwareTests
//
//  Created by Hai Kieu on 12/21/18.
//

import XCTest
@testable import SwiftyGPIO

class PWMOutputMockTests: XCTestCase {
    
    let pwm = PWMOutputMock()
    
    func testInitPWM() {
        var called = false
        pwm.initPWMClosure = { called = true }
        pwm.initPWM()
        XCTAssertTrue(called)
    }
    
    func testStartPWM() {
        var called = false
        let ns = 1
        let percent: Float = 100
        pwm.startPWMClosure = { (_ns, _percent) in
            XCTAssert(ns == _ns)
            XCTAssert(percent == _percent)
            called = true
        }
        pwm.startPWM(period: ns, duty: percent)
        XCTAssertTrue(called)
    }
    
    func testStopPWM() {
        var called = false
        pwm.stopPWMClosure = { called = true }
        pwm.stopPWM()
        XCTAssertTrue(called)
    }
    
    func testInitPWMPattern() {
        var called = false
        let count = 1
        let frequency = 2
        let resetDelay = 3
        let dutyZero = 4
        let dutyOne = 5
        pwm.initPWMPatternClosure = { (_count, _frequency, _resetdelay, _dutyZero, _dutyOne ) in
            XCTAssert(count == _count)
            XCTAssert(frequency == _frequency)
            XCTAssert(resetDelay == _resetdelay)
            XCTAssert(dutyOne == _dutyOne)
            XCTAssert(dutyZero == _dutyZero)
            called = true
        }
        pwm.initPWMPattern(bytes: count, at: frequency, with: resetDelay, dutyzero: dutyZero, dutyone: dutyOne)
        XCTAssertTrue(called)
    }
    
    func testSendDataWithPattern() {
        var called = false
        let bytes: [UInt8] = [1,2,3]
        pwm.sendDataWithPatternClosure = { (_bytes) in
            XCTAssert(bytes.count == _bytes.count)
            called = true
        }
        pwm.sendDataWithPattern(values: bytes)
        XCTAssertTrue(called)
    }
    
    func testWaitOnSendData() {
        var called = false
        pwm.waitOnSendDataClosure = { called = true }
        pwm.waitOnSendData()
        XCTAssertTrue(called)
    }
    
    func testCleanupPattern() {
        var called = false
        pwm.cleanupPatternClosure = { called = true }
        pwm.cleanupPattern()
        XCTAssertTrue(called)
    }
}
