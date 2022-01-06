//
//  RootViewController+Tests.swift
//  FitNessTests
//
//  Created by Woochan Park on 2022/01/06.
//  Copyright © 2022 Razeware. All rights reserved.
//

import Foundation
@testable import FitNess

extension RootViewController {
  var stepController: StepCountController {
    return children.first { $0 is StepCountController }
    as! StepCountController
  }
}
