//
//  DataExtensions.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import Foundation

extension Data {
    func mapToJSON() throws -> Any {
        do {
            return try JSONSerialization.jsonObject(with: self, options: [])
        } catch {
            fatalError()
        }
    }
}
