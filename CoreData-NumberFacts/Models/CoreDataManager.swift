//
//  CoreDataManager.swift
//  CoreData-NumberFacts
//
//  Created by Kelby Mittan on 4/9/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
     
    static let shared = CoreDataManager()
    
    private init () {}
    
    private var users = [User]() // User is a NSManagedObject
    
    private var posts = [Post]() // Post is a NSManagedObject
    
    // access to the persistent container in the app delegate
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func createUser(name: String, dob: Date) -> User {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        do {
            try context.save()
        } catch {
            print("error saving user: \(error)")
        }
        return user
    }
    
    public func fetchUsers() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest())
        } catch {
            print("fetching users error: \(error)")
        }
        return users
    }
    
    public func createPost(user: User, number: Double, title: String) -> Post {
        let post = Post(entity: Post.entity(), insertInto: context)
        
        post.number = number
        post.title = title
        post.user = user
        
        do {
            try context.save()
        } catch {
            print("error saving post")
        }
        return post
    }
    
    public func fetchPosts() -> [Post] {
        do {
            posts = try context.fetch(Post.fetchRequest())
        } catch {
            print("fetching posts error: \(error)")
        }
        return posts
    }
    
    @discardableResult
    public func deletePost(post: Post) -> Bool {
        context.delete(post)
        var wasDeleted = false
        do {
            try context.save()
            wasDeleted = true
        } catch {
            print("error deleting post")
        }
        return wasDeleted
    }
}
