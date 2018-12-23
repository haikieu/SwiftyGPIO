//
//  Mocks.swift
//  SwiftyGPIO
//
//  Created by Hai Kieu on 12/22/18.
//  haikieu2907@icloud.com
//
// These mock classes are created to help cut off the dependency to Raspberry Environment,
// So that when the project imports SwiftGPIO, your logic code will be able to run and verify its flows on non-raspberry environment.
//
// You should consider to put the code which uses mock in macro.
// For example:
//
// #if os(Linux)
//  let pwm = RaspberryPWM(gpioId: gpioId, alt: alt, channel: channel, baseAddr: baseAddr, dmanum: dmanum)
// #else
//  let pwm = PWMOutputMock(gpioId: gpioId, alt: alt, channel: channel, baseAddr: baseAddr, dmanum: dmanum)
// #endif

open class PWMOutputMock: PWMOutput {
    
    let gpioId: UInt
    let alt: UInt
    let channel: Int
    let pwmdma: Int
    
    let BCM2708_PERI_BASE: Int
    
    public convenience init() {
        self.init(gpioId: 0, alt: 0, channel: 0, baseAddr: 0, dmanum: 0)
    }
    
    public required init(gpioId: UInt, alt: UInt, channel: Int, baseAddr: Int, dmanum: Int) {
        self.gpioId = gpioId
        self.alt = alt
        self.channel = channel
        self.pwmdma = dmanum
        BCM2708_PERI_BASE = baseAddr
    }
    
    open var initPWMClosure: (()->Void)?
    open func initPWM() { initPWMClosure?() }
    
    open var startPWMClosure: ((_ ns: Int, _ percent: Float)->Void)?
    open func startPWM(period ns: Int, duty percent: Float) { startPWMClosure?(ns, percent) }
    
    open var stopPWMClosure: (()->Void)?
    open func stopPWM() { stopPWMClosure?() }
    
    open var initPWMPatternClosure: ((_ count: Int, _ frequency: Int, _ resetDelay: Int,_ dutyzero: Int,_ dutyone: Int)->Void)?
    open func initPWMPattern(bytes count: Int, at frequency: Int, with resetDelay: Int, dutyzero: Int, dutyone: Int) { initPWMPatternClosure?(count, frequency, resetDelay, dutyzero, dutyone) }
    
    open var sendDataWithPatternClosure: ((_ values: [UInt8])->Void)?
    open func sendDataWithPattern(values: [UInt8]) { sendDataWithPatternClosure?(values) }
    
    open var waitOnSendDataClosure: (()->Void)?
    open func waitOnSendData() { waitOnSendDataClosure?() }
    
    open var cleanupPatternClosure: (()->Void)?
    open func cleanupPattern() { cleanupPatternClosure?() }
}

open class SPIMock: SPIInterface {
    
    public func sendData(_ values: [UInt8], frequencyHz: UInt) {
        
    }
    
    public func sendData(_ values: [UInt8]) {
        
    }
    
    public func sendDataAndRead(_ values: [UInt8], frequencyHz: UInt) -> [UInt8] {
        return []
    }
    
    public func sendDataAndRead(_ values: [UInt8]) -> [UInt8] {
        return []
    }
    
    public var isHardware: Bool = true
    
    
}

open class OneWireMock: OneWireInterface {
    
    public func getSlaves() -> [String] {
        return []
    }
    
    public func readData(_ slaveId: String) -> [String] {
        return []
    }
}

open class ADCMock: ADCInterface {
    
    public var id: Int = 0
    
    public func getSample() throws -> Int {
        return 0
    }
}

open class I2CMock: I2CInterface {
    
    public func isReachable(_ address: Int) -> Bool {
        return false
    }
    
    public func setPEC(_ address: Int, enabled: Bool) {
        
    }
    
    public func readByte(_ address: Int) -> UInt8 {
        return 0
    }
    
    public func readByte(_ address: Int, command: UInt8) -> UInt8 {
        return 0
    }
    
    public func readWord(_ address: Int, command: UInt8) -> UInt16 {
        return 0
    }
    
    public func readData(_ address: Int, command: UInt8) -> [UInt8] {
        return []
    }
    
    public func writeQuick(_ address: Int) {
        
    }
    
    public func writeByte(_ address: Int, value: UInt8) {
        
    }
    
    public func writeByte(_ address: Int, command: UInt8, value: UInt8) {
        
    }
    
    public func writeWord(_ address: Int, command: UInt8, value: UInt16) {
        
    }
    
    public func writeData(_ address: Int, command: UInt8, values: [UInt8]) {
        
    }
}

open class UARTMock: UARTInterface {
    public func configureInterface(speed: UARTSpeed, bitsPerChar: CharSize, stopBits: StopBits, parity: ParityType) {
        
    }
    
    public func readString() -> String {
        return ""
    }
    
    public func readLine() -> String {
        return ""
    }
    
    public func readData() -> [CChar] {
        return []
    }
    
    public func writeString(_ value: String) {
        
    }
    
    public func writeData(_ values: [CChar]) {
        
    }
}
