//
//  CastMember.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/1/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import Foundation

struct CastMemberResponse: Decodable {
    let cast: [CastMember]
}

struct CastMember: Decodable {
    let id: Int
    let name: String
}
