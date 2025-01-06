//
//  CoreDataManager.swift
//  BookSearchApp
//
//  Created by t2023-m0033 on 12/30/24.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    // 싱글톤으로 만들기
    static let shared = CoreDataManager()
    
    private init() {}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔터티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "BookSaved"
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 읽어오기
    func getBookSavedArrayFromCoreData() -> [BookSaved] {
        
        var savedBookList: [BookSaved] = []
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기
                if let fetchedBookList = try context.fetch(request) as? [BookSaved] {
                    savedBookList = fetchedBookList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        
        return savedBookList
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성 (Document -> BookSaved)
    func saveBook(with book: Document, completion: @escaping () -> Void) {
        
        // 임시저장소 있는지 확인
        if let context = context {
            
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> BookSaved)
                if let bookSaved = NSManagedObject(entity: entity, insertInto: context) as? BookSaved {
                    
                    // MARK: - BookSaved에 실제 데이터 할당
                    bookSaved.title = book.title
                    bookSaved.authors = book.authors?.first
                    bookSaved.price = "\(book.price ?? 0)원"
                    
                    appDelegate?.saveContext()
                }
            }
        }
        completion()
    }
    
    // MARK: - [DeleteAll] 코어데이터에서 모든 데이터 삭제
    func deleteAllBooks(completion: @escaping () -> Void) {
        
        if let context = context {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                // 전체 삭제 요청
                try context.execute(deleteRequest)
                context.reset()
                completion()
            } catch {
                print("전체 삭제 실패")
                completion()
            }
        }
    }
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제
    func deleteBook(with book: BookSaved) {
        
        if let context = context {
            
            context.delete(book)
            
            appDelegate?.saveContext()
        }
    }
}
