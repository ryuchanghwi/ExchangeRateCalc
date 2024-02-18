import UIKit

struct GithubUser: Codable {
    let login: String?
    let id: Int?
    let avatarUrl: String?
    let bio: String?
}

enum GetError: Error {
    case urlERRor
    case dataMissing
}

//func getAPI(completion: @escaping (Result<GithubUser, GetError>) -> Void) {
//    let urlString = "https://api.github.com/users/sallen0400"
//    guard let url = URL(string: urlString) else { return completion(.failure(.urlERRor)) }
//
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        let jsonDedocer = JSONDecoder()
//        guard let data else { return }
//        do {
//            let user = try jsonDedocer.decode(GithubUser.self, from: data)
//        }
//        catch {
//
//        }
//    }
//}
//
//func getAsyncAPI() async throws -> Result<GithubUser, Error> {
//    let urlString = "https://api.github.com/users/sallen0400"
//    guard let url = URL(string: urlString) else { return Result.failure(GetError.urlERRor) }
//
//    let (data,_ ) = try await URLSession.shared.data(from: url)
//
//    do {
//        let decoder = JSONDecoder()
//        let user = try decoder.decode(GithubUser.self, from: data)
//        return Result.success(user)
//    }
//    catch {
//        return Result.failure(GetError.urlERRor)
//    }
//}
//let result = try await getAsyncAPI()

//func getUsers() async throws -> Result<GithubUser, GetError> {
//    let urlString = "https://api.github.com/users/sallen0400"
//    guard let url = URL(string: urlString) else { return .failure(.urlERRor) }
//    let (data, error) = try await URLSession.shared.data(from: url)
//    
//    do {
//        let decoder = JSONDecoder()
//        let user = try decoder.decode(GithubUser.self, from: data)
//        return .success(user)
//    }
//    catch {
//        return .failure(.dataMissing)
//    }
//}
//
//let data = try await getUsers()

//func getUser() async throws -> Result<GithubUser, GetError> {
//    let urlString = "https://api.github.com/users/sallen0400"
//    guard let url = URL(string: urlString) else { return .failure(.urlERRor) }
//    let (data, response) = try await URLSession.shared.data(from: url)
//    do {
//        let decoder = JSONDecoder()
//        let user = try decoder.decode(GithubUser.self, from: data)
//        return .success(user)
//    }
//    catch {
//        return .failure(.dataMissing)
//    }
//}
//
//do {
//    let result = try await getUser()
//
//    switch result {
//    case .success(let user):
//        print(user, "??")
//    case .failure(let error):
//        print(error)
//    }
//} catch {
//    print(error)
//}

//func getUser(completion: @escaping((Result<GithubUser, GetError>) -> ())) {
//    let urlString = "https://api.github.com/users/sallen0400"
//    guard let url = URL(string: urlString) else { return completion(.failure(.urlERRor)) }
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        let decoder = JSONDecoder()
//        do {
//            guard let data = data else { return completion(.failure(.dataMissing))}
//            let user = try decoder.decode(GithubUser.self, from: data)
//            completion(.success(user))
//        }
//        catch {
//            
//        }
//    }.resume()
//    
//}
//
//getUser { result in
//    switch result {
//    case .success(let user):
//        print(user)
//    case .failure(let error):
//        print(error)
//    }
//}
//
//func getUser() async throws -> Result<GithubUser, GetError> {
//    let urlString = "https://api.github.com/users/sallen0400"
//    guard let url = URL(string: urlString) else { return .failure(.urlERRor)}
//    let (data, response) = try await URLSession.shared.data(from: url)
//    do {
//        let decoder = JSONDecoder()
//        let user = try decoder.decode(GithubUser.self, from: data)
//        return .success(user)
//    }
//    catch {
//        return .failure(.dataMissing)
//    }
//}
//
//do {
//    let result = try await getUser()
//    switch result {
//    case .success(let success):
//        print(success)
//    case .failure(let failure):
//        print(failure)
//    }
//}

//func getUser(completion: @escaping (Result<GithubUser, GetError>) -> Void) {
//    let urlString = "https://api.github.com/users/sallen0400"
//    guard let url = URL(string: urlString) else { return completion(.failure(.urlERRor))}
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        guard let data = data else { return completion(.failure(.dataMissing))}
//        do {
//            let decoder = JSONDecoder()
//            let user = try decoder.decode(GithubUser.self, from: data)
//            completion(.success(user))
//            
//        } catch {
//            completion(.failure(.dataMissing))
//        }
//    }
//    .resume()
//}
//
//
//func getU() async throws -> Result<GithubUser, GetError> {
//    let urlString = "https://api.github.com/users/sallen0400"
//    guard let url = URL(string: urlString) else { return .failure(.urlERRor)}
//    do {
//        let (data, response) = try await URLSession.shared.data(from: url)
//        let jsonDecoder = JSONDecoder()
//        let user = try jsonDecoder.decode(GithubUser.self, from: data)
//        return .success(user)
//    } catch {
//        return .failure(.dataMissing)
//    }
//}
//
//do {
//    let result = try await getU()
//}

func getUser(completion: @escaping (Result<GithubUser, GetError>) -> Void) {
    let urlString = "https://api.github.com/users/sallen0400"
    guard let url = URL(string: urlString) else { return completion(.failure(.urlERRor))}
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else { return completion(.failure(.dataMissing))}
        let decoder = JSONDecoder()
        do {
            let user = try decoder.decode(GithubUser.self, from: data)
            completion(.success(user))
        } catch {
            
        }
    }.resume()
}

func getUser() async throws -> Result<GithubUser, GetError> {
    let urlString = "https://api.github.com/users/sallen0400"
    guard let url = URL(string: urlString) else { return .failure(.urlERRor) }
    let (data, response) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()
    do {
        let user = try decoder.decode(GithubUser.self, from: data)
        return .success(user)
    } catch {
        return .failure(.dataMissing)
    }
}

do {
    let result = try await getUser()
}
