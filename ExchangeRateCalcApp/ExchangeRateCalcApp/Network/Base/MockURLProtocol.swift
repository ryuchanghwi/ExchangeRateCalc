//
//  MockURLProtocol.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/19/24.
//

import Foundation
/*
 해당 코드 참고 - https://samwize.com/2022/07/07/how-to-use-urlprotocol-to-mock-networking-api/
 */

final class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var error: Error?
    override class func canInit(with request: URLRequest) -> Bool {
        true
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
