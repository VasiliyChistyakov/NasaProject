//
//  NasaImageModel.swift
//  NasaProject
//
//  Created by Чистяков Василий Александрович on 07.10.2021.
//

import Foundation

struct NasaImageModel: Codable {
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String
}
