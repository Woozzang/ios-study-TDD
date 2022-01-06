//
//  DataModelTests.swift
//  FitNessTests
//
//  Created by Woochan Park on 2022/01/06.
//  Copyright © 2022 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class DataModelTests: XCTestCase {
  
  var sut: DataModel!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    try! super.setUpWithError()
    sut = DataModel()
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
    sut = nil
    try! super.tearDownWithError()
  }
  
  func testModel_whenStepsReachGoal_goalIsReached() {
    //given
    sut.goal = 1000
    
    //when
    sut.steps = 1000
    
    //then
    XCTAssertTrue(sut.goalReached)
  }

  func testModel_whenStarted_goalIsNotReached() {
    XCTAssertFalse(sut.goalReached, "goalReached should be false when the model is created")
  }
  
  // MARK: - Nessie
  
  func testModel_whenStarted_userIsNotCaught() {
    XCTAssertFalse(sut.caught)
  }
  
  func testModel_whenUserAheadOfNessie_isNotCaught() {
    // given
    sut.distance = 1000
    sut.nessie.distance = 100
    
    // then
    XCTAssertFalse(sut.caught)
  }
  
  func testModel_whenNessieAheadofUser_isCaught() {
    //given
    
    sut.nessie.distance = 1000
    sut.distance = 100
    
    //then
    XCTAssertTrue(sut.caught)
  }
  
  func testModel_whenUserCaught_cannnotBeReached() {
    //given 목표를 설정한 상황에서
    sut.goal = 1000
    sut.steps = 1000
    
    // when 네씨에게 잡혔다면
    sut.distance = 100
    sut.nessie.distance = 100
    
    // then 더이상 목표를 달성할수 없다
    XCTAssertFalse(sut.goalReached)
  }
  
}
