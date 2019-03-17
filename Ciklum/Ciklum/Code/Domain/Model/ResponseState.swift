//
//  ResponseState.swift
//  Ciklum
//
//  Created by Mikael Melkonyan on 3/17/19.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

enum ResponseState<Instance> {
    case error(String)
    case success(Instance)
}
