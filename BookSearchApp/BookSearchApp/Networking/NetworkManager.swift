//
//  NetworkManager.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import Foundation

//MARK: - 네트워크에서 발생할 수 있는 에러 정의
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

//MARK: - Networking (서버와 통신하는) 클래스 모델
final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // TypeAlias
    typealias NetworkCompletion = (Result<[Document], NetworkError>) -> Void
    
    // 검색 단어로 네트워킹 요청하는 함수 (책데이터 가져오기)
    func fetchBooks(searchTerm: String, completion: @escaping NetworkCompletion) {
        
        let urlString = "https://dapi.kakao.com/v3/search/book?query=\(searchTerm)"
        
        performRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    // 실제 Request하는 함수
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        print(#function)
        guard let url = URL(string: urlString) else { return }
        
        // url로 request 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 헤더추가
        request.allHTTPHeaderFields = ["Authorization": "KakaoAK 8405c074cb889605fb781c8f328a6b5f"]
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            // 메서드 실행해서, 결과를 받음
            if let books = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(books))
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // 받아본 JSON 데이터 분석하는 함수
    private func parseJSON(_ bookData: Data) -> [Document]? {
        print(#function)
        
        // 성공
        do {
            // (JSON 데이터 -> BookData 구조체)
            let bookData = try JSONDecoder().decode(BookData.self, from: bookData)
            return bookData.documents
            // 실패
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
