//
//  DesignPattern-Structural.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/24.
//

import Foundation

/// 구조
// 브리지 패턴
protocol Message {
    var messageString: String {get set}
    init(messageString: String)
    func prepareMessage()
}

// 메세지를 보내기 전에 검증하는 요구 사항 추가
protocol Sender {
    var message: Message? {get set}
    func sendMessage()
    func verifyMessage()
    
}

class PlainTextMessage: Message {
    var messageString: String
    
    required init(messageString: String) {
        self.messageString = messageString
    }
    
    func prepareMessage() {
        // 아무것도 안함
    }
}

class DESEncyptedMessage: Message {
    var messageString: String
    
    required init(messageString: String) {
        self.messageString = messageString
    }
    
    func prepareMessage() {
        // 암호화한 메시지 생성
        self.messageString = "DES: " + self.messageString
    }
}

class EmailSender: Sender {
    var message: Message?
    
    func sendMessage() {
        print("Sending through E-Mail:")
        print(" \(message!.messageString)")
    }
    
    func verifyMessage() {
        print("Verifying E-Mail message")
    }
}

class SMSSender: Sender {
    var message: Message?
    
    func sendMessage() {
        print("Sending through SMS: ")
        print(" \(message!.messageString)")
    }
    
    func verifyMessage() {
        print("Verifying SMS message")
    }
}

var myMessage = PlainTextMessage(messageString: "Plain Text Message")
myMessage.prepareMessage()
var sender = SMSSender()
sender.message = myMessage
sender.verifyMessage()
sender.sendMessage()

// 위의 작업 단위를 하나로 묶는 브릿지 타입 생성
struct MessageBridge {
    static func sendMessage(message: Message, sender: Sender) {
        var sender = sender
        message.prepareMessage()
        sender.message = message
        sender.verifyMessage()
        sender.sendMessage()
    }
}

// 퍼사드 패턴
struct Hotel {
    // 호텔 객실에 대한 정보
}

struct HotelBooking {
    static func getHotelNameForDates(to: Date, from: Date) -> [Hotel]? {
        let hotels = [Hotel]()
        // 호텔을 가져오는 로직
        return hotels
    }
    
    static func bookHotel(hotel: Hotel) {
        // 호텔 객실을 예약하는 로직
    }
}

struct Flight {
    // 항공기에 대한 정보
}

struct FlightBooking {
    static func getFlightNameForDates(to: Date, from: Date) -> [Flight]? {
        let flights = [Flight]()
        // 항공기를 가져오는 로직
        return flights
    }
    
    static func bookFlight(flight: Flight) {
        // 항공기를 예약하는 로직
    }
}

struct RentalCar {
    // 렌터카에 대한 정보
}

struct RentalCarBooking {
    static func getRentalCarNameForDates(to: Date, from: Date) -> [RentalCar]? {
        let cars = [RentalCar]()
        // 렌터카를 가져오는 로직
        return cars
    }
    
    static func bookRentalCar(rentalCar: RentalCar) {
        // 렌터카를 예약하는 로직
    }
}

// 퍼사드 패턴 구현
struct TravelFacade {
    var hotels: [Hotel]?
    var flights: [Flight]?
    var cars: [RentalCar]?
    
    // 각각의 API에 직접 접근할 필요 없이 이 타입을 사용하여 검색, 예약할 수 있다.
    init(to: Date, from: Date) {
        hotels = HotelBooking.getHotelNameForDates(to: to, from: from)
        flights = FlightBooking.getFlightNameForDates(to: to, from: from)
        cars = RentalCarBooking.getRentalCarNameForDates(to: to, from: from)
    }
    
    func bookTrip(hotel: Hotel, flight: Flight, rentalCar: RentalCar) {
        HotelBooking.bookHotel(hotel: hotel)
        FlightBooking.bookFlight(flight: flight)
        RentalCarBooking.bookRentalCar(rentalCar: rentalCar)
    }
}

// 프록시 디자인 패턴
// 코드와 원격 API 사이에 추상 계층을 추가
// iTunes API에 정보를 검색하는 프록시 타입
public typealias DataFromURLCompletionClosure = (Data?) -> Void
public struct ITunesProxy {
    public func sendGetRequest(searchTerm: String, _ handler: @escaping DataFromURLCompletionClosure) {
        let sessionConfiguration = URLSessionConfiguration.default
        var url = URLComponents()
        
        // url이 변경 되어도 여기서만 바꾸면 된다.
        url.scheme = "https"
        url.host = "itunes.apple.com"
        url.path = "/search"
        url.queryItems = [URLQueryItem(name: "term", value: searchTerm)]
        
        if let queryUrl = url.url {
            var request = URLRequest(url: queryUrl)
            request.httpMethod = "GET"
            
            let urlSession = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: nil)
            let sessionTask = urlSession.dataTask(with: request) { (data, response, error) in
                handler(data)
            }
            sessionTask.resume()
        }
    }
}

let proxy = ITunesProxy()
proxy.sendGetRequest(searchTerm: "jimmy+buffett") {
    if let data = $0, let sString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
        print(sString)
    } else {
        print("Data is nil")
    }
}
