//
//  IdentifiableError.swift
//  News-Concurrency
//
//  Created by Rodrigo on 05/03/2025.
//

import Foundation

struct IdentifiableError: Identifiable {
    let id = UUID()
    let error: Error
}
