import AppKit
import Foundation

private let canvasSize = NSSize(width: 800, height: 800)
private let imageRoot = URL(
    fileURLWithPath: "assets/images",
    isDirectory: true
)

private struct DonutStyle {
    let backgroundStart: NSColor
    let backgroundEnd: NSColor
    let accent: NSColor
    let glaze: [NSColor]
    let sprinkles: [NSColor]
    let drizzle: NSColor?
}

private struct ShopStyle {
    let skyStart: NSColor
    let skyEnd: NSColor
    let wall: NSColor
    let awning: NSColor
    let windowFrame: NSColor
}

private func color(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> NSColor {
    NSColor(calibratedRed: red, green: green, blue: blue, alpha: 1)
}

private func fill(_ rect: NSRect, with fillColor: NSColor) {
    fillColor.setFill()
    NSBezierPath(rect: rect).fill()
}

private func oval(_ rect: NSRect, with fillColor: NSColor) {
    fillColor.setFill()
    NSBezierPath(ovalIn: rect).fill()
}

private func roundedRect(
    _ rect: NSRect,
    radius: CGFloat,
    with fillColor: NSColor
) {
    fillColor.setFill()
    NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius).fill()
}

private func ring(_ outer: NSRect, hole: NSRect, with fillColor: NSColor) {
    let path = NSBezierPath()
    path.windingRule = .evenOdd
    path.appendOval(in: outer)
    path.appendOval(in: hole)
    fillColor.setFill()
    path.fill()
}

private func ringGradient(
    _ outer: NSRect,
    hole: NSRect,
    colors: [NSColor],
    angle: CGFloat = 90
) {
    let path = NSBezierPath()
    path.windingRule = .evenOdd
    path.appendOval(in: outer)
    path.appendOval(in: hole)
    NSGraphicsContext.saveGraphicsState()
    path.addClip()
    NSGradient(colors: colors)?.draw(in: outer, angle: angle)
    NSGraphicsContext.restoreGraphicsState()
}

private func drawGradient(
    in rect: NSRect,
    start: NSColor,
    end: NSColor,
    angle: CGFloat = 90
) {
    NSGradient(starting: start, ending: end)?.draw(in: rect, angle: angle)
}

private func withShadow(
    color: NSColor,
    blur: CGFloat,
    offset: NSSize,
    draw: () -> Void
) {
    NSGraphicsContext.saveGraphicsState()
    let shadow = NSShadow()
    shadow.shadowColor = color
    shadow.shadowBlurRadius = blur
    shadow.shadowOffset = offset
    shadow.set()
    draw()
    NSGraphicsContext.restoreGraphicsState()
}

private func bitmap(for image: NSImage) throws -> NSBitmapImageRep {
    guard
        let bitmap = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: 800,
            pixelsHigh: 800,
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .deviceRGB,
            bytesPerRow: 0,
            bitsPerPixel: 0
        ),
        let context = NSGraphicsContext(bitmapImageRep: bitmap)
    else {
        throw NSError(
            domain: "ArtPreview",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Could not render image"]
        )
    }

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context
    image.draw(in: NSRect(origin: .zero, size: canvasSize))
    context.flushGraphics()
    NSGraphicsContext.restoreGraphicsState()
    return bitmap
}

private func writeJpeg(_ image: NSImage, path: String) throws {
    let bitmap = try bitmap(for: image)
    guard let data = bitmap.representation(
        using: .jpeg,
        properties: [.compressionFactor: 0.9]
    ) else {
        throw NSError(domain: "ArtPreview", code: 2)
    }
    try write(data, path: path)
}

private func writePng(_ image: NSImage, path: String) throws {
    let bitmap = try bitmap(for: image)
    guard let data = bitmap.representation(using: .png, properties: [:]) else {
        throw NSError(domain: "ArtPreview", code: 3)
    }
    try write(data, path: path)
}

private func write(_ data: Data, path: String) throws {
    let url = imageRoot.appendingPathComponent(path)
    try FileManager.default.createDirectory(
        at: url.deletingLastPathComponent(),
        withIntermediateDirectories: true
    )
    try data.write(to: url)
}

private func drawDonut(_ style: DonutStyle) -> NSImage {
    let image = NSImage(size: canvasSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    let bounds = NSRect(origin: .zero, size: canvasSize)
    drawGradient(
        in: bounds,
        start: style.backgroundStart,
        end: style.backgroundEnd
    )
    oval(
        NSRect(x: 86, y: 536, width: 194, height: 194),
        with: style.accent.withAlphaComponent(0.34)
    )
    oval(
        NSRect(x: 584, y: 66, width: 150, height: 150),
        with: style.accent.withAlphaComponent(0.22)
    )

    withShadow(
        color: color(0.24, 0.18, 0.17).withAlphaComponent(0.2),
        blur: 32,
        offset: NSSize(width: 4, height: -24)
    ) {
        oval(
            NSRect(x: 174, y: 188, width: 456, height: 110),
            with: color(0.42, 0.28, 0.21).withAlphaComponent(0.16)
        )
    }

    NSGraphicsContext.saveGraphicsState()
    let transform = NSAffineTransform()
    transform.translateX(by: 400, yBy: 400)
    transform.rotate(byDegrees: -13)
    transform.translateX(by: -400, yBy: -400)
    transform.concat()

    let outer = NSRect(x: 175, y: 282, width: 450, height: 310)
    let hole = NSRect(x: 333, y: 365, width: 136, height: 118)
    ringGradient(
        outer,
        hole: hole,
        colors: [color(0.48, 0.25, 0.14), color(0.78, 0.47, 0.25)]
    )
    ringGradient(
        outer.insetBy(dx: 24, dy: 20),
        hole: hole.insetBy(dx: -4, dy: -4),
        colors: [color(0.99, 0.78, 0.49), color(0.86, 0.56, 0.31)]
    )
    ringGradient(
        outer.insetBy(dx: 14, dy: 22),
        hole: hole.insetBy(dx: 15, dy: 12),
        colors: style.glaze
    )
    oval(NSRect(x: 246, y: 342, width: 58, height: 45), with: style.glaze[1])
    oval(NSRect(x: 491, y: 332, width: 54, height: 47), with: style.glaze[1])
    oval(NSRect(x: 303, y: 334, width: 36, height: 34), with: style.glaze[1])
    oval(NSRect(x: 446, y: 330, width: 38, height: 36), with: style.glaze[1])
    ring(hole, hole: hole.insetBy(dx: 17, dy: 14), with: color(0.52, 0.25, 0.17))
    oval(hole.insetBy(dx: 19, dy: 16), with: color(0.91, 0.84, 0.76))

    drawSprinkles(style.sprinkles)
    drawIcingHighlights(style.glaze[2])
    if let drizzle = style.drizzle {
        drawDrizzle(drizzle)
    }
    NSGraphicsContext.restoreGraphicsState()

    return image
}

private func drawIcingHighlights(_ tint: NSColor) {
    let highlight = NSBezierPath()
    highlight.move(to: NSPoint(x: 268, y: 536))
    highlight.curve(
        to: NSPoint(x: 344, y: 558),
        controlPoint1: NSPoint(x: 291, y: 558),
        controlPoint2: NSPoint(x: 316, y: 563)
    )
    highlight.lineWidth = 12
    highlight.lineCapStyle = .round
    tint.withAlphaComponent(0.68).setStroke()
    highlight.stroke()
}

private func drawSprinkles(_ palette: [NSColor]) {
    let width: CGFloat = 22
    let height: CGFloat = 7
    let positions: [(CGFloat, CGFloat)] = [
        (260, 548), (314, 572), (381, 566), (456, 567),
        (526, 548), (230, 506), (285, 518), (333, 531),
        (472, 526), (542, 508), (244, 465), (291, 476),
        (502, 475), (550, 462), (278, 428), (518, 428),
    ]

    for (index, (x, y)) in positions.enumerated() {
        let tint = palette[index % palette.count]
        NSGraphicsContext.saveGraphicsState()
        let transform = NSAffineTransform()
        transform.translateX(by: x, yBy: y)
        transform.rotate(byDegrees: 34)
        transform.translateX(by: -x, yBy: -y)
        transform.concat()
        roundedRect(
            NSRect(x: x, y: y, width: width, height: height),
            radius: height / 2,
            with: tint
        )
        NSGraphicsContext.restoreGraphicsState()
    }
}

private func drawDrizzle(_ tint: NSColor) {
    for offset in [0.0, 48.0, 96.0] {
        let stripe = NSBezierPath()
        stripe.move(to: NSPoint(x: 318 + offset, y: 596))
        stripe.curve(
            to: NSPoint(x: 282 + offset, y: 410),
            controlPoint1: NSPoint(x: 350 + offset, y: 552),
            controlPoint2: NSPoint(x: 274 + offset, y: 474)
        )
        stripe.lineWidth = 9
        stripe.lineCapStyle = .round
        tint.setStroke()
        stripe.stroke()
    }
}

private func drawMiniDonut(
    centerX: CGFloat,
    centerY: CGFloat,
    scale: CGFloat,
    glaze: NSColor,
    sprinkle: NSColor
) {
    NSGraphicsContext.saveGraphicsState()
    let transform = NSAffineTransform()
    transform.translateX(by: centerX, yBy: centerY)
    transform.scale(by: scale)
    transform.translateX(by: -centerX, yBy: -centerY)
    transform.concat()

    let outer = NSRect(x: centerX - 56, y: centerY - 38, width: 112, height: 76)
    let hole = NSRect(x: centerX - 17, y: centerY - 13, width: 34, height: 27)
    ringGradient(
        outer,
        hole: hole,
        colors: [color(0.52, 0.27, 0.16), color(0.92, 0.62, 0.34)]
    )
    ringGradient(
        outer.insetBy(dx: 5, dy: 8),
        hole: hole.insetBy(dx: -2, dy: -2),
        colors: [glaze.withAlphaComponent(0.78), glaze]
    )
    ring(hole, hole: hole.insetBy(dx: 8, dy: 7), with: color(0.50, 0.25, 0.16))
    let sprinkles: [(CGFloat, CGFloat)] = [
        (-30, 12), (-8, 24), (18, 19), (34, 3),
    ]
    for (dx, dy) in sprinkles {
        oval(
            NSRect(x: centerX + dx, y: centerY + dy, width: 7, height: 4),
            with: sprinkle
        )
    }
    NSGraphicsContext.restoreGraphicsState()
}

private func drawAssortedBox(holiday: Bool) -> NSImage {
    let image = NSImage(size: canvasSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    drawGradient(
        in: NSRect(origin: .zero, size: canvasSize),
        start: holiday ? color(0.97, 0.87, 0.82) : color(0.88, 0.93, 0.94),
        end: color(0.99, 0.96, 0.89)
    )
    withShadow(
        color: color(0.24, 0.18, 0.17).withAlphaComponent(0.2),
        blur: 25,
        offset: NSSize(width: 0, height: -14)
    ) {
        roundedRect(
            NSRect(x: 104, y: 145, width: 592, height: 500),
            radius: 34,
            with: color(0.83, 0.67, 0.48)
        )
    }
    roundedRect(
        NSRect(x: 128, y: 170, width: 544, height: 451),
        radius: 26,
        with: color(0.99, 0.93, 0.79)
    )
    for (index, point) in [
        (260, 488), (400, 488), (540, 488),
        (260, 300), (400, 300), (540, 300),
    ].enumerated() {
        let shades = [
            color(0.94, 0.34, 0.55),
            color(0.46, 0.32, 0.68),
            color(0.43, 0.27, 0.17),
            color(0.98, 0.79, 0.53),
        ]
        let glaze = shades[(index + (holiday ? 1 : 0)) % shades.count]
        drawMiniDonut(
            centerX: CGFloat(point.0),
            centerY: CGFloat(point.1),
            scale: 1.0,
            glaze: glaze,
            sprinkle: color(1.0, 0.88, 0.68)
        )
    }
    roundedRect(
        NSRect(x: 340, y: 106, width: 120, height: 82),
        radius: 16,
        with: holiday ? color(0.78, 0.29, 0.38) : color(0.28, 0.62, 0.70)
    )
    return image
}

private func drawCoffee() -> NSImage {
    let image = NSImage(size: canvasSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    drawGradient(
        in: NSRect(origin: .zero, size: canvasSize),
        start: color(0.97, 0.91, 0.83),
        end: color(0.86, 0.93, 0.93)
    )
    withShadow(
        color: color(0.24, 0.18, 0.17).withAlphaComponent(0.22),
        blur: 28,
        offset: NSSize(width: 0, height: -18)
    ) {
        oval(
            NSRect(x: 226, y: 130, width: 348, height: 70),
            with: color(0.26, 0.19, 0.14).withAlphaComponent(0.2)
        )
    }

    let cup = NSBezierPath(
        roundedRect: NSRect(x: 280, y: 165, width: 242, height: 470),
        xRadius: 38,
        yRadius: 38
    )
    NSGraphicsContext.saveGraphicsState()
    cup.addClip()
    drawGradient(
        in: cup.bounds,
        start: color(0.98, 0.95, 0.86),
        end: color(0.70, 0.79, 0.76)
    )
    drawGradient(
        in: NSRect(x: 280, y: 165, width: 242, height: 320),
        start: color(0.83, 0.64, 0.43),
        end: color(0.34, 0.20, 0.14)
    )
    drawGradient(
        in: NSRect(x: 280, y: 450, width: 242, height: 115),
        start: color(0.98, 0.91, 0.76),
        end: color(0.86, 0.70, 0.53)
    )
    NSGraphicsContext.restoreGraphicsState()
    oval(
        NSRect(x: 292, y: 582, width: 218, height: 34),
        with: color(0.35, 0.22, 0.16)
    )
    roundedRect(
        NSRect(x: 328, y: 638, width: 158, height: 18),
        radius: 9,
        with: color(0.35, 0.22, 0.16)
    )
    oval(
        NSRect(x: 495, y: 335, width: 90, height: 150),
        with: color(0.70, 0.79, 0.76).withAlphaComponent(0.75)
    )
    oval(
        NSRect(x: 516, y: 359, width: 48, height: 102),
        with: color(0.97, 0.91, 0.83)
    )
    return image
}

private func drawPromoBanner(
    background: NSColor,
    accent: NSColor,
    glaze: NSColor
) -> NSImage {
    let image = NSImage(size: canvasSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    drawGradient(
        in: NSRect(origin: .zero, size: canvasSize),
        start: background,
        end: background.blended(withFraction: 0.25, of: .white) ?? .white
    )
    oval(
        NSRect(x: 470, y: 178, width: 430, height: 430),
        with: accent.withAlphaComponent(0.5)
    )
    oval(
        NSRect(x: 535, y: 240, width: 310, height: 310),
        with: background.withAlphaComponent(0.7)
    )
    drawMiniDonut(
        centerX: 620,
        centerY: 400,
        scale: 2.1,
        glaze: glaze,
        sprinkle: color(1.0, 0.89, 0.67)
    )
    roundedRect(
        NSRect(x: 72, y: 287, width: 246, height: 20),
        radius: 10,
        with: color(1.0, 1.0, 1.0).withAlphaComponent(0.54)
    )
    roundedRect(
        NSRect(x: 72, y: 246, width: 174, height: 13),
        radius: 6,
        with: color(1.0, 1.0, 1.0).withAlphaComponent(0.34)
    )
    return image
}

private func drawGiftBox() -> NSImage {
    let image = NSImage(size: canvasSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    drawGradient(
        in: NSRect(origin: .zero, size: canvasSize),
        start: color(0.98, 0.90, 0.84),
        end: color(0.91, 0.94, 0.92)
    )
    roundedRect(
        NSRect(x: 150, y: 180, width: 500, height: 410),
        radius: 32,
        with: color(0.91, 0.68, 0.54)
    )
    roundedRect(
        NSRect(x: 132, y: 532, width: 536, height: 105),
        radius: 25,
        with: color(0.98, 0.79, 0.66)
    )
    fill(
        NSRect(x: 370, y: 180, width: 60, height: 457),
        with: color(0.41, 0.66, 0.69)
    )
    fill(
        NSRect(x: 132, y: 552, width: 536, height: 54),
        with: color(0.41, 0.66, 0.69)
    )
    drawMiniDonut(
        centerX: 400,
        centerY: 403,
        scale: 1.65,
        glaze: color(0.90, 0.29, 0.51),
        sprinkle: color(1.0, 0.88, 0.64)
    )
    return image
}

private func drawGiftCoffeeSet() -> NSImage {
    let image = NSImage(size: canvasSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    drawGradient(
        in: NSRect(origin: .zero, size: canvasSize),
        start: color(0.91, 0.93, 0.97),
        end: color(0.99, 0.91, 0.84)
    )
    roundedRect(
        NSRect(x: 146, y: 174, width: 508, height: 118),
        radius: 28,
        with: color(0.46, 0.34, 0.63)
    )
    roundedRect(
        NSRect(x: 212, y: 286, width: 376, height: 323),
        radius: 42,
        with: color(0.91, 0.77, 0.59)
    )
    roundedRect(
        NSRect(x: 268, y: 248, width: 264, height: 285),
        radius: 46,
        with: color(0.97, 0.94, 0.84)
    )
    oval(
        NSRect(x: 278, y: 492, width: 244, height: 48),
        with: color(0.36, 0.22, 0.15)
    )
    drawMiniDonut(
        centerX: 400,
        centerY: 446,
        scale: 1.15,
        glaze: color(0.69, 0.37, 0.22),
        sprinkle: color(0.94, 0.73, 0.43)
    )
    return image
}

private func drawAvatar() -> NSImage {
    let image = NSImage(size: canvasSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    drawGradient(
        in: NSRect(origin: .zero, size: canvasSize),
        start: color(0.99, 0.87, 0.80),
        end: color(0.91, 0.80, 0.89)
    )
    oval(
        NSRect(x: 108, y: 72, width: 584, height: 584),
        with: color(0.99, 0.94, 0.87)
    )
    oval(
        NSRect(x: 238, y: 62, width: 324, height: 290),
        with: color(0.35, 0.22, 0.18)
    )
    oval(
        NSRect(x: 280, y: 214, width: 240, height: 310),
        with: color(0.77, 0.49, 0.35)
    )
    oval(
        NSRect(x: 222, y: -70, width: 356, height: 340),
        with: color(0.41, 0.57, 0.65)
    )
    oval(
        NSRect(x: 277, y: 238, width: 246, height: 255),
        with: color(0.82, 0.56, 0.41)
    )
    oval(
        NSRect(x: 270, y: 352, width: 260, height: 187),
        with: color(0.35, 0.22, 0.18)
    )
    oval(
        NSRect(x: 301, y: 347, width: 198, height: 178),
        with: color(0.82, 0.56, 0.41)
    )
    oval(NSRect(x: 325, y: 385, width: 18, height: 12), with: color(0.24, 0.18, 0.16))
    oval(NSRect(x: 457, y: 385, width: 18, height: 12), with: color(0.24, 0.18, 0.16))
    oval(
        NSRect(x: 367, y: 335, width: 68, height: 12),
        with: color(0.58, 0.30, 0.27)
    )
    return image
}

private func drawPlaceholder() -> NSImage {
    let image = NSImage(size: canvasSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    oval(
        NSRect(x: 104, y: 104, width: 592, height: 592),
        with: color(0.94, 0.95, 0.95)
    )
    ringGradient(
        NSRect(x: 224, y: 265, width: 352, height: 246),
        hole: NSRect(x: 346, y: 328, width: 108, height: 118),
        colors: [color(0.83, 0.85, 0.86), color(0.71, 0.74, 0.75)]
    )
    ring(
        NSRect(x: 346, y: 328, width: 108, height: 118),
        hole: NSRect(x: 368, y: 350, width: 64, height: 74),
        with: color(0.66, 0.69, 0.70)
    )
    return image
}

private func drawShop(_ style: ShopStyle) -> NSImage {
    let image = NSImage(size: canvasSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    let bounds = NSRect(origin: .zero, size: canvasSize)
    drawGradient(
        in: bounds,
        start: style.skyStart,
        end: style.skyEnd
    )
    oval(
        NSRect(x: 590, y: 590, width: 96, height: 96),
        with: color(1.0, 0.89, 0.64).withAlphaComponent(0.82)
    )
    fill(
        NSRect(x: 0, y: 0, width: 800, height: 154),
        with: color(0.77, 0.84, 0.69)
    )
    fill(
        NSRect(x: 0, y: 0, width: 800, height: 78),
        with: color(0.65, 0.76, 0.59)
    )

    withShadow(
        color: color(0.16, 0.22, 0.19).withAlphaComponent(0.25),
        blur: 26,
        offset: NSSize(width: 0, height: -15)
    ) {
        roundedRect(
            NSRect(x: 112, y: 142, width: 576, height: 516),
            radius: 24,
            with: style.wall
        )
    }

    fill(
        NSRect(x: 112, y: 532, width: 576, height: 126),
        with: style.awning
    )
    roundedRect(
        NSRect(x: 268, y: 570, width: 266, height: 58),
        radius: 25,
        with: color(0.94, 0.72, 0.52)
    )
    let awningLight = style.awning.blended(
        withFraction: 0.28,
        of: .white
    ) ?? .white
    for x in stride(from: 278, through: 518, by: 60) {
        fill(
            NSRect(x: CGFloat(x), y: 570, width: 30, height: 58),
            with: awningLight
        )
    }

    drawDisplayWindow(
        x: 326,
        y: 320,
        width: 140,
        height: 178,
        frameColor: style.windowFrame
    )
    drawDisplayWindow(
        x: 488,
        y: 320,
        width: 162,
        height: 178,
        frameColor: style.windowFrame
    )
    roundedRect(
        NSRect(x: 153, y: 247, width: 148, height: 232),
        radius: 12,
        with: style.windowFrame
    )
    fill(
        NSRect(x: 168, y: 263, width: 118, height: 202),
        with: color(0.79, 0.89, 0.83)
    )
    fill(
        NSRect(x: 221, y: 263, width: 7, height: 202),
        with: style.windowFrame
    )
    roundedRect(
        NSRect(x: 247, y: 352, width: 9, height: 9),
        radius: 4,
        with: color(0.94, 0.72, 0.52)
    )
    fill(
        NSRect(x: 168, y: 347, width: 118, height: 5),
        with: color(0.36, 0.62, 0.63)
    )

    oval(NSRect(x: 376, y: 581, width: 48, height: 40), with: color(0.99, 0.82, 0.56))
    ring(NSRect(x: 386, y: 589, width: 28, height: 24), hole: NSRect(x: 394, y: 596, width: 12, height: 10), with: color(0.75, 0.37, 0.22))
    drawPlanter(x: 66, y: 114, scale: 1.0)
    drawPlanter(x: 658, y: 118, scale: 0.82)
    oval(
        NSRect(x: 534, y: 305, width: 12, height: 12),
        with: color(0.96, 0.73, 0.52)
    )
    oval(
        NSRect(x: 576, y: 346, width: 10, height: 10),
        with: color(0.96, 0.73, 0.52)
    )

    return image
}

private func drawDisplayWindow(
    x: CGFloat,
    y: CGFloat,
    width: CGFloat,
    height: CGFloat,
    frameColor: NSColor
) {
    let frame = NSRect(x: x, y: y, width: width, height: height)
    roundedRect(frame, radius: 12, with: frameColor)
    let glass = frame.insetBy(dx: 10, dy: 10)
    drawGradient(
        in: glass,
        start: color(0.96, 0.83, 0.65),
        end: color(0.76, 0.88, 0.82)
    )
    for shelfY in [y + 55, y + 112] {
        fill(
            NSRect(x: x + 12, y: shelfY, width: width - 24, height: 7),
            with: color(0.88, 0.68, 0.47)
        )
    }

    let pastryColors = [
        color(0.91, 0.47, 0.28),
        color(0.95, 0.70, 0.42),
        color(0.82, 0.31, 0.38),
    ]
    for (index, pastryX) in stride(from: x + 24, through: x + width - 42, by: 38)
        .enumerated()
    {
        let tint = pastryColors[index % pastryColors.count]
        oval(
            NSRect(x: pastryX, y: y + 27, width: 27, height: 21),
            with: tint
        )
        oval(
            NSRect(x: pastryX + 8, y: y + 33, width: 10, height: 8),
            with: color(0.96, 0.83, 0.65)
        )
        oval(
            NSRect(x: pastryX + 2, y: y + 83, width: 27, height: 21),
            with: pastryColors[(index + 1) % pastryColors.count]
        )
        oval(
            NSRect(x: pastryX + 10, y: y + 89, width: 10, height: 8),
            with: color(0.96, 0.83, 0.65)
        )
    }
    fill(
        NSRect(x: x + width * 0.52, y: y + 10, width: 5, height: height - 20),
        with: color(0.92, 0.87, 0.76)
    )
}

private func drawPlanter(x: CGFloat, y: CGFloat, scale: CGFloat) {
    NSGraphicsContext.saveGraphicsState()
    let transform = NSAffineTransform()
    transform.translateX(by: x, yBy: y)
    transform.scale(by: scale)
    transform.translateX(by: -x, yBy: -y)
    transform.concat()

    roundedRect(
        NSRect(x: x, y: y, width: 84, height: 72),
        radius: 12,
        with: color(0.82, 0.48, 0.35)
    )
    let leaves: [(CGFloat, CGFloat, CGFloat, CGFloat)] = [
        (x + 5, y + 60, 28, 94),
        (x + 26, y + 65, 28, 112),
        (x + 47, y + 62, 27, 96),
    ]
    for (leafX, leafY, width, height) in leaves {
        oval(
            NSRect(x: leafX, y: leafY, width: width, height: height),
            with: color(0.31, 0.52, 0.39)
        )
    }
    NSGraphicsContext.restoreGraphicsState()
}

private let sprinklePalette = [
    color(1.0, 0.82, 0.26),
    color(0.31, 0.72, 0.77),
    color(1.0, 0.95, 0.86),
    color(0.46, 0.34, 0.68),
    color(0.42, 0.70, 0.43),
]
private let pinkDonut = DonutStyle(
    backgroundStart: color(0.99, 0.96, 0.92),
    backgroundEnd: color(0.88, 0.95, 0.97),
    accent: color(0.84, 0.54, 0.68),
    glaze: [color(0.79, 0.12, 0.39), color(0.95, 0.30, 0.56), color(1.0, 0.55, 0.68)],
    sprinkles: sprinklePalette,
    drizzle: nil
)
private let otherDonuts = [
    (
        "strawberry_chocolate_donut.jpg",
        DonutStyle(
            backgroundStart: color(0.99, 0.91, 0.91),
            backgroundEnd: color(0.97, 0.82, 0.84),
            accent: color(0.80, 0.37, 0.47),
            glaze: [color(0.24, 0.11, 0.10), color(0.39, 0.20, 0.16), color(0.59, 0.33, 0.23)],
            sprinkles: [color(0.98, 0.76, 0.80), color(1.0, 0.94, 0.82)],
            drizzle: color(0.96, 0.37, 0.57)
        )
    ),
    (
        "purple_glazed_donut.jpg",
        DonutStyle(
            backgroundStart: color(0.91, 0.90, 0.98),
            backgroundEnd: color(0.84, 0.90, 0.96),
            accent: color(0.53, 0.43, 0.76),
            glaze: [color(0.36, 0.24, 0.62), color(0.55, 0.39, 0.78), color(0.75, 0.62, 0.91)],
            sprinkles: [color(1.0, 0.79, 0.87), color(1.0, 0.90, 0.63), color(0.82, 0.91, 0.95)],
            drizzle: nil
        )
    ),
    (
        "coconut_flake_donut.jpg",
        DonutStyle(
            backgroundStart: color(0.98, 0.93, 0.84),
            backgroundEnd: color(0.91, 0.93, 0.86),
            accent: color(0.84, 0.71, 0.52),
            glaze: [color(0.76, 0.68, 0.57), color(0.95, 0.89, 0.77), color(1.0, 0.98, 0.91)],
            sprinkles: [color(1.0, 0.98, 0.88), color(0.85, 0.75, 0.60)],
            drizzle: nil
        )
    ),
    (
        "caramel_glazed_donut.jpg",
        DonutStyle(
            backgroundStart: color(0.98, 0.91, 0.81),
            backgroundEnd: color(0.94, 0.85, 0.73),
            accent: color(0.86, 0.61, 0.37),
            glaze: [color(0.58, 0.31, 0.16), color(0.82, 0.49, 0.24), color(0.98, 0.70, 0.37)],
            sprinkles: [color(0.35, 0.20, 0.14), color(1.0, 0.88, 0.64)],
            drizzle: nil
        )
    ),
]

try writeJpeg(drawDonut(pinkDonut), path: "previews/donut_preview.jpg")
for (name, style) in otherDonuts {
    try writeJpeg(drawDonut(style), path: "products/\(name)")
}
try writeJpeg(drawAssortedBox(holiday: false), path: "products/assorted_donut_box.jpg")
try writeJpeg(drawAssortedBox(holiday: true), path: "products/seasonal_mixed_box.jpg")
try writeJpeg(drawCoffee(), path: "products/dalgona_coffee.jpg")
try writeJpeg(
    drawPromoBanner(
        background: color(0.39, 0.34, 0.66),
        accent: color(0.91, 0.57, 0.70),
        glaze: color(0.93, 0.27, 0.53)
    ),
    path: "banners/seasonal_promo.jpg"
)
try writeJpeg(
    drawPromoBanner(
        background: color(0.32, 0.68, 0.75),
        accent: color(0.97, 0.76, 0.55),
        glaze: color(0.47, 0.31, 0.67)
    ),
    path: "banners/new_shop_promo.jpg"
)

private let shopStyles = [
    (
        "shop_preview.jpg",
        ShopStyle(
            skyStart: color(0.72, 0.88, 0.90),
            skyEnd: color(0.96, 0.88, 0.77),
            wall: color(0.97, 0.92, 0.82),
            awning: color(0.27, 0.53, 0.55),
            windowFrame: color(0.36, 0.62, 0.63)
        ),
        "previews"
    ),
    (
        "shop_02.jpg",
        ShopStyle(
            skyStart: color(0.97, 0.82, 0.84),
            skyEnd: color(0.99, 0.91, 0.80),
            wall: color(0.98, 0.88, 0.80),
            awning: color(0.73, 0.36, 0.51),
            windowFrame: color(0.62, 0.34, 0.47)
        ),
        "shops"
    ),
    (
        "shop_03.jpg",
        ShopStyle(
            skyStart: color(0.78, 0.88, 0.96),
            skyEnd: color(0.90, 0.93, 0.93),
            wall: color(0.88, 0.91, 0.90),
            awning: color(0.29, 0.48, 0.67),
            windowFrame: color(0.30, 0.51, 0.66)
        ),
        "shops"
    ),
    (
        "shop_04.jpg",
        ShopStyle(
            skyStart: color(0.98, 0.86, 0.68),
            skyEnd: color(0.94, 0.91, 0.79),
            wall: color(0.96, 0.88, 0.72),
            awning: color(0.79, 0.42, 0.27),
            windowFrame: color(0.57, 0.35, 0.26)
        ),
        "shops"
    ),
]
for (name, style, directory) in shopStyles {
    try writeJpeg(drawShop(style), path: "\(directory)/\(name)")
}

try writeJpeg(drawGiftBox(), path: "gifts/donut_gift_box.jpg")
try writeJpeg(drawGiftCoffeeSet(), path: "gifts/coffee_gift_set.jpg")
try writeJpeg(drawAvatar(), path: "members/demo_avatar.jpg")
try writePng(drawPlaceholder(), path: "placeholders/image_fallback.png")
