//
//  File.swift
//  SpaceFoundation
//
//  Created by Sai Madhukar Somu on 1/24/25.
//

import Foundation
import SwiftUI

struct SpaceProgressAnimation: View {
    @State private var progress: CGFloat = 0.0
    private let animationDuration: Double = 2.0
    
    private let text: String
    
    init(text: String = "G r o w S p a c e") {
        self.text = text
    }
       
       var body: some View {
           GeometryReader { geometry in
               let path = createTextPath(in: geometry.size)
               ZStack {
                   path.stroke(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                       .foregroundColor(.gray)
                   
                   path.trim(from: progress, to: progress + 0.1)
                       .stroke(Color.blue, lineWidth: 2)
                       .animation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: false), value: progress)
               }
               .onAppear {
                   progress = 1.0
               }
           }
       }
       
    private func createTextPath(in size: CGSize) -> Path {
           var path = Path()
           let font = UIFont.systemFont(ofSize: 40)
           let attributedString = NSAttributedString(string: text, attributes: [.font: font])
           let line = CTLineCreateWithAttributedString(attributedString)
           let runs = CTLineGetGlyphRuns(line) as! [CTRun]
           
           for run in runs {
               let attributes = CTRunGetAttributes(run) as! [CFString: Any]
               let font = attributes[kCTFontAttributeName as CFString] as! CTFont
               for i in 0..<CTRunGetGlyphCount(run) {
                   let glyphRange = CFRangeMake(i, 1)
                   var glyph = CGGlyph()
                   var position = CGPoint()
                   CTRunGetGlyphs(run, glyphRange, &glyph)
                   CTRunGetPositions(run, glyphRange, &position)
                   if let letterPath = CTFontCreatePathForGlyph(font, glyph, nil) {
                       let x = position.x + (size.width - attributedString.size().width) / 2
                       let y = position.y + (size.height - 20) / 2
                       
                       path.addPath(Path(letterPath), transform: CGAffineTransform(translationX: x, y: y))
                   }
               }
           }
           
           return path
       }

}


#Preview {
    SpaceProgressAnimation()
        .frame(width: 200, height: 200)
}
