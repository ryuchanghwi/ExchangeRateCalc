//
//  GetServiceCombine.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/31/24.
//

import Foundation
import Combine
class URLProtocolMock: URLProtocol {
    // this dictionary maps URLs to test data
    static var testURLs = [URL?: Data]()
    static var response: URLResponse?
    static var error: Error?
    
    // say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    } // URLProtocol의 subClass가 특정한 요청을 처리할 수 있는지 여부
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    } // URLProtocol의 subClass가 특정한 작업을 처리할 수 있는지 여부

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    } // 지정된 요청의 정식 버전을 반환??
    
    override func startLoading() {
        // if we have a valid URL…
        if let url = request.url {
            // …and if we have test data for that URL…
            if let data = URLProtocolMock.testURLs[url] {
                // …load it immediately.
                self.client?.urlProtocol(self, didLoad: data)
            }
        }
        
        // …and we return our response if defined…
        if let response = URLProtocolMock.response {
            self.client?.urlProtocol(self,
                                     didReceive: response,
                                     cacheStoragePolicy: .notAllowed)
        }
        
        // …and we return our error if defined…
        if let error = URLProtocolMock.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        // mark that we've finished
        self.client?.urlProtocolDidFinishLoading(self)
    }

    // this method is required but doesn't need to do anything
    override func stopLoading() {
    }
    // Request가 끝났을 때 혹은 중지됐을 때, 처리할 행동을 정의하는 메서드
}

final class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var error: Error?
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    override func startLoading() {
        if let error = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() {
    }
}



protocol APIDataTaskPublisher {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}
class APISessionDataPublisher: APIDataTaskPublisher {
    
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        return session.dataTaskPublisher(for: request)
    }
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
class GetServiceCombine {
    let dataPublisehr: APIDataTaskPublisher
    init(dataPublisehr: APIDataTaskPublisher) {
        self.dataPublisehr = dataPublisehr
    }
    func request<T>(from url: String) -> AnyPublisher<T, ErrorTypes> where T : Decodable {
        guard let apiUrl = URL(string: url) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return dataPublisehr.dataTaskPublisher(for: URLRequest(url: apiUrl))
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                ErrorTypes.decoingError
            }
            .eraseToAnyPublisher()
    }
}
