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
    
    public var isHardware: Bool = true
    
    var sendDataWithFrequencyClosure: ((_ values: [UInt8],_ frequencyHz: UInt)->Void)?
    public func sendData(_ values: [UInt8], frequencyHz: UInt) {
        sendDataWithFrequencyClosure?(values, frequencyHz)
    }
    
    var sendDataClosure: ((_ values: [UInt8])->Void)?
    public func sendData(_ values: [UInt8]) {
        sendDataClosure?(values)
    }
    
    var sendDataAndReadWithFrequencyClosure: ((_ values: [UInt8],_ frequencyHz: UInt) -> [UInt8])?
    public func sendDataAndRead(_ values: [UInt8], frequencyHz: UInt) -> [UInt8] {
        return sendDataAndReadWithFrequencyClosure?(values, frequencyHz) ?? []
    }
    
    var sendDataAndReadClosure: ((_ values: [UInt8]) -> [UInt8])?
    public func sendDataAndRead(_ values: [UInt8]) -> [UInt8] {
        return sendDataAndReadClosure?(values) ?? []
    }
}

open class OneWireMock: OneWireInterface {
    
    var getSlavesClosure: (()->[String])?
    public func getSlaves() -> [String] {
        return getSlavesClosure?() ?? []
    }
    
    var readDataClosure: ((_ slaveId: String) -> [String])?
    public func readData(_ slaveId: String) -> [String] {
        return readDataClosure?(slaveId) ?? []
    }
}

open class ADCMock: ADCInterface {
    
    public var id: Int = 0
    
    var getSampleClosure: (()->Int)?
    public func getSample() throws -> Int {
        return getSampleClosure?() ?? 0
    }
}

open class I2CMock: I2CInterface {
    
    var isReachableClosure: ((_ address: Int) -> Bool)?
    public func isReachable(_ address: Int) -> Bool {
        return isReachableClosure?(address) ?? true
    }
    
    var setPECClosure: ((_ address: Int,_ enabled: Bool)->Void)?
    public func setPEC(_ address: Int, enabled: Bool) {
        setPECClosure?(address, enabled)
    }
    
    var readByteClosure: ((_ address: Int) -> UInt8)?
    public func readByte(_ address: Int) -> UInt8 {
        return readByteClosure?(address) ?? 0
    }
    
    var readByteCommandClosure: ((_ address: Int,_ command: UInt8) -> UInt8)?
    public func readByte(_ address: Int, command: UInt8) -> UInt8 {
        return readByteCommandClosure?(address, command) ?? 0
    }
    
    var readWordClosure: ((_ address: Int,_ command: UInt8) -> UInt16)?
    public func readWord(_ address: Int, command: UInt8) -> UInt16 {
        return readWordClosure?(address, command) ?? 0
    }
    
    var readDataClosure: ((_ address: Int,_ command: UInt8) -> [UInt8])?
    public func readData(_ address: Int, command: UInt8) -> [UInt8] {
        return readDataClosure?(address,command) ?? []
    }
    
    var writeQuickClosure: ((_ address: Int)->Void)?
    public func writeQuick(_ address: Int) {
        writeQuickClosure?(address)
    }
    
    var writeByteClosure: ((_ address: Int,_ value: UInt8)->Void)?
    public func writeByte(_ address: Int, value: UInt8) {
        writeByteClosure?(address,value)
    }
    
    var writeByteCommandClosure: ((_ address: Int,_ command: UInt8,_ value: UInt8)->Void)?
    public func writeByte(_ address: Int, command: UInt8, value: UInt8) {
        writeByteCommandClosure?(address,command,value)
    }
    
    var writeWordClosure: ((_ address: Int,_ command: UInt8,_ value: UInt16)->Void)?
    public func writeWord(_ address: Int, command: UInt8, value: UInt16) {
        writeWordClosure?(address, command, value)
    }
    
    var writeDataClosure: ((_ address: Int,_ command: UInt8,_ values: [UInt8])->Void)?
    public func writeData(_ address: Int, command: UInt8, values: [UInt8]) {
        writeDataClosure?(address,command,values)
    }
}

open class UARTMock: UARTInterface {
    
    var configureInterfaceClosure: ((_ speed: UARTSpeed,_ bitsPerChar: CharSize,_ stopBits: StopBits,_ parity: ParityType)->Void)?
    public func configureInterface(speed: UARTSpeed, bitsPerChar: CharSize, stopBits: StopBits, parity: ParityType) {
        configureInterfaceClosure?(speed,bitsPerChar,stopBits,parity)
    }
    
    var readStringClosure: (()->String)?
    public func readString() -> String {
        return readStringClosure?() ?? ""
    }
    
    var readLineClosure: (()->String)?
    public func readLine() -> String {
        return readLineClosure?() ?? ""
    }
    
    var readDataClosure: (()->[CChar])?
    public func readData() -> [CChar] {
        return readDataClosure?() ?? []
    }
    
    var writeStringClousure: ((_ value: String)->Void)?
    public func writeString(_ value: String) {
        writeStringClousure?(value)
    }
    
    var writeDataClosure: ((_ values: [CChar])->Void)?
    public func writeData(_ values: [CChar]) {
        writeDataClosure?(values)
    }
}
