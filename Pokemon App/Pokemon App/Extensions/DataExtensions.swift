//
//  DataExtensions.swift
//  Pokemon app
//
//  Created by Matheus Martins on 10/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import Foundation

extension Data {
    //MARK: - Support method, to debug requests
    func mapToJSON() throws -> Any {
        do {
            return try JSONSerialization.jsonObject(with: self, options: [])
        } catch {
            fatalError()
        }
    }
}
