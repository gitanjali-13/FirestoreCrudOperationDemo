//
//  ViewController.swift
//  FirestoreCrudOperationDemo
//
//  Created by Admin on 11/01/23.
//

import UIKit
import FirebaseCore
import FirebaseAnalytics
import FirebaseFirestore

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let db = Firestore.firestore()
        
        //adding documents
        db.collection("Wine").addDocument(data: ["year":2020, "type":"pinot-noir", "label":"peller-estates"])
        
        //adding data into document using same documnent id
        let newDocument = db.collection("wine").document()
        newDocument.setData(["year" :2017,"type": "abc", "label":"peller", "id":newDocument.documentID])
        
        
        //add document with specific id , not auto-generated id , here we can update key and fields that we r added to dta
        db.collection("books").document("price").setData(["maths":200, "english":100,"physics": 250],merge: true)
        //handle completion wiht error
        
        
        db.collection("Wine").addDocument(data: ["test" : "test1"]) { error in
            if let error = error {
                //there is an error adding data.
            }
            else {
                //error is nil add data successfully.
            }
        }
        //delete document from collection with document id
                db.collection("books").document("price").delete()
        
        //delete a field from book collection-> price documents -> field maths
        db.collection("books").document("price").updateData(["maths":FieldValue.delete()])
        
        //detect error using completion parameter
        
        db.collection("books").document("price").delete{ (error) in
            if error != nil {
                //error
            } else {
                //deleting successfully})
                }
           }
        
        
        //detecting all documents from collection
        
        db.collection("Wine").document("pinot-noir-2020").getDocument { document, error in
            if error == nil {
                //if this document exists
                if document != nil && document!.exists {

                  let documentData = document!.data()
                }
            }
        }
        
        //getting all document from the collection Wine
        
        db.collection("Wine").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil{
                for document in snapshot!.documents {
                    let documentData = document.data()
                }
            }
        }
        
        //getting subset of documents
        db.collection("Wine").whereField("year", isEqualTo: 2020).getDocuments { (snapshot, error) in
            if error  == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let data = document.data()
                }
            }
        }
        
        
    }
}
