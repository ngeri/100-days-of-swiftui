//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Gergely Németh on 2019. 11. 28..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    var succesHandler: (() -> Void)?
    var errorHandler: ((Error?) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            succesHandler?()
        }
    }
}
