
import Foundation
import SwiftUI

public protocol SpaceImage {
    var load: Image { get }
}
 

public enum FoundationImage: String, SpaceImage {
    
    case rightArrow
    case darkMode
    
    public var load: Image {
        return Image(self.rawValue, bundle: .module)
    }
}


#Preview {
    VStack {
        
        FoundationImage.rightArrow.load
            .frame(width: 24, height: 24)
    }
    .background(Color.white)
}
