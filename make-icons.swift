import Cocoa

struct IconSpec {
	let filename: String
	let symbolName: String
	let tint: NSColor
}

let icons: [IconSpec] = [
	IconSpec(filename: "icon-start.png", symbolName: "iphone", tint: NSColor(white: 0.6, alpha: 1.0)),
	IconSpec(filename: "icon-stop.png", symbolName: "iphone.gen3.radiowaves.left.and.right", tint: NSColor.systemGreen)
]

let size = NSSize(width: 288, height: 288)
let outDir = "/Users/viktorodman/fun/streamdeck"

for spec in icons {
	let config = NSImage.SymbolConfiguration(pointSize: 180, weight: .regular)
	guard let baseSymbol = NSImage(systemSymbolName: spec.symbolName, accessibilityDescription: nil)?.withSymbolConfiguration(config) else {
		print("Failed to load symbol \(spec.symbolName)")
		continue
	}
	baseSymbol.isTemplate = true

	let canvas = NSImage(size: size)
	canvas.lockFocus()

	// Black background
	NSColor.black.setFill()
	NSBezierPath(rect: NSRect(origin: .zero, size: size)).fill()

	// Center the symbol
	let symSize = baseSymbol.size
	let symRect = NSRect(
		x: (size.width - symSize.width) / 2,
		y: (size.height - symSize.height) / 2,
		width: symSize.width,
		height: symSize.height
	)

	// Tint the symbol
	let tinted = NSImage(size: symSize)
	tinted.lockFocus()
	baseSymbol.draw(at: .zero, from: NSRect(origin: .zero, size: symSize), operation: .sourceOver, fraction: 1.0)
	spec.tint.set()
	NSRect(origin: .zero, size: symSize).fill(using: .sourceIn)
	tinted.unlockFocus()

	tinted.draw(in: symRect, from: .zero, operation: .sourceOver, fraction: 1.0)
	canvas.unlockFocus()

	guard let tiff = canvas.tiffRepresentation,
		let bitmap = NSBitmapImageRep(data: tiff),
		let png = bitmap.representation(using: .png, properties: [:]) else {
		print("Encode failed for \(spec.filename)")
		continue
	}

	let outPath = "\(outDir)/\(spec.filename)"
	try? png.write(to: URL(fileURLWithPath: outPath))
	print("Wrote \(outPath)")
}
