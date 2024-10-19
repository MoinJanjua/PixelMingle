//
//  HomeViewController.swift
//  PixelMingle
//
//  Created by Moin Janjua on 23/08/2024.
//

import UIKit
import ZLImageEditor
import iOSPhotoEditor

class HomeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
 
    enum ImageEditorType {
           case zlImageEditor
           case iOSPhotoEditor
       }
    @IBOutlet weak var SideMenu: UIView!
    @IBOutlet weak var sideMenuTB: UITableView!
    @IBOutlet weak var vesion_Label: UILabel!
    @IBOutlet weak var TimeLbl: UILabel!

    @IBOutlet weak var posterIV: UIImageView!
    @IBOutlet weak var wallpapers_btn: UIButton!
    @IBOutlet weak var makeCollage_btn: UIButton!
    @IBOutlet weak var customEdit_btn: UIButton!
    @IBOutlet weak var editPicture_btn: UIButton!
    
    var sideMenuList = [String]()
    var resultImageEditModel : ZLEditImageModel?
    var selectedEditor: ImageEditorType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuList = ["Home","Share Your Thoughts","Who We Are","Privacy Notice","Share App"]
        sideMenuTB.delegate = self
        sideMenuTB.dataSource = self
        SideMenu.isHidden = true
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "N/A"
       let build = Bundle.main.infoDictionary?["CFBundleVersion"] ?? "N/A"
        vesion_Label.text = "Version \(version) (\(build))"
        
        setGreetingMessage()
    
        wallpapers_btn.applyCustomStyle(cornerRadius: 10, shadowColor: .darkGray, shadowOffset: CGSize(width: 0, height: 2), shadowOpacity: 0.4, shadowRadius: 6.0, backgroundOpacity: 1.0)
        wallpapers_btn.applyCustomStyle(cornerRadius: 10, shadowColor: .darkGray, shadowOffset: CGSize(width: 0, height: 2), shadowOpacity: 0.4, shadowRadius: 6.0, backgroundOpacity: 1.0)
        makeCollage_btn.applyCustomStyle(cornerRadius: 15, shadowColor: .black, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.5, shadowRadius: 5.0, backgroundOpacity: 0.9)
        customEdit_btn.applyCustomStyle(cornerRadius: 20, shadowColor: .lightGray, shadowOffset: CGSize(width: 0, height: 1), shadowOpacity: 0.3, shadowRadius: 4.0, backgroundOpacity: 0.8)
        editPicture_btn.applyCustomStyle(cornerRadius: 20, shadowColor: .gray, shadowOffset: CGSize(width: 0, height: 3), shadowOpacity: 0.5, shadowRadius: 5.0, backgroundOpacity: 0.8)
    }
    private func setGreetingMessage() {
           let hour = Calendar.current.component(.hour, from: Date())
           var greeting: String
           
           switch hour {
           case 5..<12:
               greeting = "Good Morning"
           case 12..<17:
               greeting = "Good Afternoon"
           case 17..<21:
               greeting = "Good Evening"
           default:
               greeting = "Good Night"
           }
        TimeLbl.text = greeting
       }
    func openGallery(for editorType: ImageEditorType) {
          selectedEditor = editorType // Set the editor type based on the button pressed
          let imagePicker = UIImagePickerController()
          imagePicker.delegate = self
          imagePicker.sourceType = .photoLibrary
          self.present(imagePicker, animated: true, completion: nil)
      }
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else {
                picker.dismiss(animated: true, completion: nil)
                return
            }
            picker.dismiss(animated: true) {
                // Call the appropriate function based on the selected editor type
                switch self.selectedEditor {
                case .zlImageEditor:
                    self.editImage(selectedImage, editModel: nil)
                case .iOSPhotoEditor:
                    self.openiOSPhotoEditor(with: selectedImage)
                case .none:
                    break
                }
            }
        }
   func editImage(_ image: UIImage, editModel: ZLEditImageModel?) {
           ZLEditImageViewController.showEditImageVC(parentVC: self, image: image, editModel: editModel) { [weak self] editedImage, editModel in
               if editedImage != nil {
                   self?.resultImageEditModel = editModel

                   // Save the edited image to the photo library
                   UIImageWriteToSavedPhotosAlbum(editedImage, nil, nil, nil)

                   // Optionally, display an alert to inform the user that the image has been saved
                   let alert = UIAlertController(title: "Saved!", message: "Your edited image has been successfully saved.", preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alert.addAction(okAction)
                   self?.present(alert, animated: true, completion: nil)
               } else {
                   // Handle the case where editedImage is nil
               }
           }
       }
    func openiOSPhotoEditor(with image: UIImage) {
           let photoEditor = PhotoEditorViewController(nibName: "PhotoEditorViewController", bundle: Bundle(for: PhotoEditorViewController.self))
           photoEditor.image = image
           
           // Customize the photo editor
           for i in 0...10 {
               if let sticker = UIImage(named: "\(i)") {
                   photoEditor.stickers.append(sticker)
               }
           }
        photoEditor.modalPresentationStyle = UIModalPresentationStyle.fullScreen
           present(photoEditor, animated: true, completion: nil)
       }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func MenuButton(_ sender: Any) {
        SideMenu.isHidden = false
    }
    @IBAction func cancelButton(_ sender: Any) {
        SideMenu.isHidden = true
    }
    @IBAction func editButtonTapped(_ sender: UIButton) {
        openGallery(for: .zlImageEditor)
      }
    @IBAction func ImageEditorButton(_ sender: Any) {
        openGallery(for: .iOSPhotoEditor)
    }
        @IBAction func MakeCollageButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "SelectLayoutViewController") as! SelectLayoutViewController
               newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
               newViewController.modalTransitionStyle = .crossDissolve
               self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func WallpaperButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "WallpaperViewController") as! WallpaperViewController
               newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
               newViewController.modalTransitionStyle = .crossDissolve
               self.present(newViewController, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! SideMenuTableViewCell
        cell.sidemenu_label.text = sideMenuList[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
     }
        if indexPath.item == 1 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        if indexPath.item == 2 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        if indexPath.item == 3 {
            // Open Privacy Policy Link
            if let url = URL(string: "https://jtechapps.pages.dev/privacy") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        if indexPath.item == 4 {
            let appID = "AssetAssign" // Replace with your actual App ID
            let appURL = URL(string: "https://apps.apple.com/app/id\(appID)")!
            let activityViewController = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
        }
    }

