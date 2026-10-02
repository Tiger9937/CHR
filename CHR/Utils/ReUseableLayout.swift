import UIKit

class GridLayoutStructure: UIView {
    
    var horizontalSpacing: CGFloat = 10
    var verticalSpacing: CGFloat = 10
    
    /// The height needed to fit all capsules after wrapping.
    private(set) var currentHeight: CGFloat = 0 {
        didSet {
            guard currentHeight != oldValue else { return }
            invalidateIntrinsicContentSize()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var currentRowHeight: CGFloat = 0
        
        for capsule in subviews {
            
            let size = capsule.systemLayoutSizeFitting(
                UIView.layoutFittingCompressedSize
            )
            let capsuleWidth = size.width
            let capsuleHeight = size.height
            
            // Move to next row if capsule doesn't fit
            if currentX > 0 && currentX + capsuleWidth > bounds.width {
                
                currentX = 0
                currentY += currentRowHeight + verticalSpacing
                currentRowHeight = 0
            }
            
            capsule.frame = CGRect(
                x: currentX,
                y: currentY,
                width: capsuleWidth,
                height: capsuleHeight
            )
            
            currentX += capsuleWidth + horizontalSpacing
            currentRowHeight = max(
                currentRowHeight,
                capsuleHeight
            )
        }
        
        // Final row's height wasn't folded in above since the loop
        // only compares before placing the *next* capsule — add it here.
        currentHeight = currentY + currentRowHeight
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: currentHeight)
    }
}
