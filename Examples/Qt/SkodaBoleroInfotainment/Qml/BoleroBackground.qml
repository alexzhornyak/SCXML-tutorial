import QtQuick 2.0
import "BoleroConstants.js" as Consts

Rectangle {
    id: background
    color: Consts.cl_BACKGROUND

    Canvas {
        id: canvas
        anchors.fill: parent
        anchors.margins: 3
        contextType: "2d"

        function drawLines(ctx, x0,y0,x1,y1) {
            var gradient = ctx.createLinearGradient(x0,y0,x1,y1)
            gradient.addColorStop(0, Consts.cl_BACKGROUND_LIGHT)
            gradient.addColorStop(0.4, Consts.cl_BACKGROUND)
            ctx.strokeStyle = gradient

            ctx.beginPath()
            ctx.moveTo(x0, y0)
            ctx.lineTo(x1, y1)
            ctx.stroke()
        }

        onPaint: {
            context.save()
            context.lineWidth = 2

            var widthOffset = width/2

            for (var i = 0 - widthOffset; i < width + widthOffset;i+= width/60) {
                /* top lines */
                drawLines(context, i, 0, i / widthOffset + widthOffset, height/2)

                /* bottom lines */
                drawLines(context, i, height, i / widthOffset + widthOffset, height/2)
            }
            context.restore()
        }
    }
}

