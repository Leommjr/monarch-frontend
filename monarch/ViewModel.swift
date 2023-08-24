//
//  ViewModel.swift
//  monarch
//
//  Created by Student17 on 22/08/23.
//

import Foundation

enum TipoPonto: String, Codable {
    case pontoEvento = "PontoEvento"
    case pontoEncontro = "PontoEncontro"
    case pontoFixo = "PontoFixo"
}
struct EventTime: Codable {
    var start: Int64
    var finish: Int64
}// Unix timestamp

struct Local: Codable {
    var x: Double?
    var y: Double?
}

struct User: Codable {
    var _id: String?
    var _rev: String?
    var name: String?
    var friends: [String]? //array com o id de cada amigo
    var status: String?
    var image: String?
    var visibility: Bool?
    var localization: Local?
}

struct Location: Decodable, Identifiable {
    var id = UUID()
    var _id: String
    var _rev: String
    var name: String?
    var description: String?
    var localization: Local?
    var type: TipoPonto
    var creatorId: String?
    var image: String?
    var pin: String?
    var duration: EventTime?
}
/*
struct EncounterPoint: Codable {
    var _id: String?
    var _rev: String?
    var creatorId: String? // Id do criador
}

struct FixedPoint: Codable {
    var _id: String?
    var _rev: String?
    var creatorId: String?
    var image: String?
}

struct Event: Codable {
    var _id: String?
    var _rev: String?
    var creatorId: String?
    var image: String?
    var duration: EventTime?
}
*/
class ViewModel : ObservableObject {
    @Published var locations: [Location] = []
    @Published var user: User?
    
    func getLocations() async {
        guard let url = URL(string: "http://192.168.128.239:1880/locationstest") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Location].self, from: data) {
                DispatchQueue.main.async {
                    self.locations = decodedResponse
                }
            }
        } catch {
            print("invalid data")
        }
    }
    
    func getUserById(userId: String) async {
        guard let url = URL(string: "http://192.168.128.239:1880/userstest?id=\(userId)") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
                DispatchQueue.main.async {
                    self.user = decodedResponse
                }
            }
        } catch {
            print("invalid data")
        }
    }
}
