/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
import CoreMotion
@testable import FitNess

class PedometerTests: XCTestCase {
  //swiftlint:disable implicitly_unwrapped_optional
  var sut: CMPedometer!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = CMPedometer()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testCMPedometer_whenQueries_loadsHistoricData() {
    // given
    var error: Error?
    var data: CMPedometerData?
    
    /// 비동기 테스트를 위한 메서드 : 예상한다
    let exp = expectation(description: "pedometer query returns")
    
    // when
    let now = Date()
    let then = now.addingTimeInterval(-1000)
    sut.queryPedometerData(from: then, to: now) { pedometerData, pedometerError in
      
      error = pedometerError
      data = pedometerData
      
      /// fulfill 을 호출함으로서 실제 예상이 실현되었는지 확인할 수 있다.
      exp.fulfill()
    }
    
    // then
    /// 비동기 동작이 실행될때까지 제어를 잡고 있는다.
    /// timeout 이 지나기 전까지 fulfill 이 호출되지 않으면 test fail 이다.
    wait(for: [exp], timeout: 1)
    
    XCTAssertNil(error)
    XCTAssertNotNil(data)
    
    if let steps = data?.numberOfSteps {
      XCTAssertGreaterThan(steps.intValue, 0)
    } else {
      XCTFail("no step data")
    }
  }
}
