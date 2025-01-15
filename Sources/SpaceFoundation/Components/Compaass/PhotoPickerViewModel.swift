//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/6/25.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
public class PhotoPickerViewModel: ObservableObject {
    @Environment(\.dismiss) var dismiss
    
    @Published public var selectedImage: Image?
    @Published public var imagePickerItem: PhotosPickerItem? {
        didSet {
            loadTransferable(from: imagePickerItem)
        }
    }
    
    public init() {
        self.selectedImage = selectedImage
    }

    func loadTransferable(from selection: PhotosPickerItem?) {
        guard let selection = selection else { return }
        Task {
            do {
                if let result: Image = try await selection.loadTransferable(type: Image.self) {
                    selectedImage = result
                }
            } catch let error {
                print("Error: \(error)")
                selectedImage = nil
            }
        }
    }
}
