//
//  Mocks.swift
//  SwiftyGPIO
//
//  Created by Hai Kieu on 12/22/18.
//

open class PWMOutputMock: PWMOutput {
    
    public init() {}
    
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
