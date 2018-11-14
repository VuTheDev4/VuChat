//
//  CollectionReference.swift
//  VuChat
//
//  Created by Vu Duong on 11/7/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Typing
    case Recent
    case Message
    case Group
    case Call
}


func reference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
