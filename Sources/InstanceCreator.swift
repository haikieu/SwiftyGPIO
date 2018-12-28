//
//  DependencyManager.swift
//  SwiftyGPIO
//
//  Created by Hai Kieu on 12/23/18.
//

public class InstanceCreator {
    
    public static var enableMock: Bool = false
    
    public static func initSysFSUART(_ uartIdList: [String]) -> UARTInterface? {
        
        #if os(macOS)
        if enableMock {
            return UARTMock(uartIdList)
        }
        #endif
        return SysFSUART(uartIdList)
    }
    
    public static func initSysFSSPI(spiId: String) -> SPIInterface {
        
        #if os(macOS)
        if enableMock {
            return SPIMock(spiId: spiId)
        }
        #endif
        return SysFSSPI(spiId: spiId)
    }
    
    public static func initSysFSI2C(i2cId: Int) -> I2CInterface {
        
        #if os(macOS)
        if enableMock {
            return I2CMock(i2cId: i2cId)
        }
        #endif
        return SysFSI2C(i2cId: i2cId)
    }
    
    public static func initSysFSADC(adcPath: String, id: Int) -> ADCInterface {
        
        #if os(macOS)
        if enableMock {
            return ADCMock(adcPath: adcPath, id: id)
        }
        #endif
        return SysFSADC(adcPath: adcPath, id: id)
    }
    
    public static func initSysFSOneWire(masterId: Int) -> OneWireInterface {
        
        #if os(macOS)
        if enableMock {
            return OneWireMock(masterId: masterId)
        }
        #endif
        return SysFSOneWire(masterId: masterId)
    }
    
    public static func initRaspberryPWM(gpioId: UInt, alt: UInt, channel: Int, baseAddr: Int, dmanum: Int = 5) -> PWMOutput {
        
        #if os(macOS)
        if enableMock {
            return PWMOutputMock(gpioId: gpioId, alt: alt, channel: channel, baseAddr: baseAddr, dmanum: dmanum)
        }
        #endif
        return RaspberryPWM(gpioId: gpioId, alt: alt, channel: channel, baseAddr: baseAddr, dmanum: dmanum)
    }
}
