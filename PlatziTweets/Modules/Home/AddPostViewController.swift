//
//  AddPostViewController.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 8/05/21.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift
import FirebaseStorage

class AddPostViewController: UIViewController {
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var previewImageView: UIImageView!
    
    private var imagePicker: UIImagePickerController?
    
    @IBAction func openCameraAction() {
        openCamera()
    }
    
    @IBAction func AddPostAction() {
        uploadPhotoToFirebase()
    }
    
    @IBAction func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func savePost(imageUrl: String?) {
        
        guard let post = postTextView.text, !post.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar un post", style: .warning).show()
            return
        }
        
        let request = PostRequest(text: post, imageUrl: imageUrl, videoUrl: nil, location: nil)
        
        SVProgressHUD.show()
        
        SN.post(endpoint: Endpoints.post, model: request) { (response: SNResultWithEntity<Post, ErrorResponse>) in
            
            SVProgressHUD.dismiss()
            
            switch response {
            case .success:
                self.dismiss(animated: true, completion: nil)
                
            case .error(let error):
                NotificationBanner(subtitle: "Error: \(error.localizedDescription)", style: .danger).show()
                return
                
            case .errorResult(let entity):
                NotificationBanner(subtitle: "Error Result: \(entity.error)", style: .danger).show()
                return
                
            }
            
        }
        
    }
    
    private func openCamera() {
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .camera
        imagePicker?.cameraFlashMode = .off
        imagePicker?.cameraCaptureMode = .photo
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        
        guard let imagePicker = imagePicker else {
            return
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func uploadPhotoToFirebase() {
        //1. Asegurarnos de que la foto exista
        //2. Comprimir la imagen y convertirla en Data
        guard let imageSaved = previewImageView.image,
              let imageSavedData: Data = imageSaved.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        //3. Mostrar procesando
        SVProgressHUD.show()
        
        //4. Configuración para guardar la foto en firebase
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "image/jpg"
        
        //5. Referencia al storage de firebase
        let storage = Storage.storage()
        
        //6. Crear nombre de la imagen a subir
        let imageName = UUID().uuidString
        
        //7. Referencia a la carpeta donde se va a guardar la foto
        let folderReference = storage.reference(withPath: "fotos-tweets/\(imageName).jpg")
        
        //8. Subir la foto a Firebase
        DispatchQueue.global(qos: .background).async {
            folderReference.putData(imageSavedData, metadata: metaDataConfig) { (metaData: StorageMetadata?, error: Error?) in
                
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    
                    if let error = error {
                        NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger).show()
                        return
                    }
                    
                    //Obtener la URL de descarga
                    folderReference.downloadURL { (url: URL?, error: Error?) in
                        let downloadUrl = url?.absoluteString ?? ""
                        self.savePost(imageUrl: downloadUrl)
                        
                    }
                }
            }
        }
    }
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePicker?.dismiss(animated: true, completion: nil)
        
        if info.keys.contains(.originalImage) {
            previewImageView.isHidden = false
            previewImageView.image = info[.originalImage] as? UIImage
        }
    }
}



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


