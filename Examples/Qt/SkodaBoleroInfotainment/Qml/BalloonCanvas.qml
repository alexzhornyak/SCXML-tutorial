import QtQuick 2.0

Canvas {
    id: canvas

    enum BalloonDirection {
        Left = 0,
        Bottom
    }

    property real contentMargin: radius + lineWidth
    property alias contentData: content.data

    property int radius: 4
    property int rectx: x + offsetX + lineWidth
    property int recty: y + lineWidth
    property int rectWidth: width - lineWidth * 2 - offsetX
    property int rectHeight: height - offsetY - lineWidth

    property int offsetX: balloonDirection === BalloonCanvas.BalloonDirection.Left ? triangleEdge : 0
    property int offsetY: balloonDirection === BalloonCanvas.BalloonDirection.Bottom ? triangleEdge : 0

    property color strokeStyle: "white"
    property color fillStyle: "black"
    property int lineWidth: 2
    property bool fill: true
    property bool stroke: true
    property real alpha: 1.0
    property real triangleEdge: 10
    property real triangleOffset: triangleEdge * 2
    property int balloonDirection: BalloonCanvas.BalloonDirection.Left

    onLineWidthChanged:requestPaint();
    onFillChanged:requestPaint();
    onStrokeChanged:requestPaint();
    onRadiusChanged:requestPaint();

    onPaint: {
        var ctx = getContext("2d");
        ctx.save();
        ctx.reset()
        ctx.clearRect(0,0,canvas.width, canvas.height);
        ctx.strokeStyle = canvas.strokeStyle;
        ctx.lineWidth = canvas.lineWidth
        ctx.fillStyle = canvas.fillStyle
        ctx.globalAlpha = canvas.alpha

        ctx.beginPath();
        ctx.moveTo(rectx+radius,recty);                 // top side
        ctx.lineTo(rectx+rectWidth-radius,recty);
        // draw top right corner
        ctx.arcTo(rectx+rectWidth,recty,rectx+rectWidth,recty+radius,radius);
        ctx.lineTo(rectx+rectWidth,recty+rectHeight-radius);    // right side
        // draw bottom right corner
        ctx.arcTo(rectx+rectWidth,recty+rectHeight,rectx+rectWidth-radius,recty+rectHeight,radius);

        if (balloonDirection === BalloonCanvas.BalloonDirection.Bottom) {
            ctx.lineTo(rectx + triangleOffset + triangleEdge * 2, recty + rectHeight)
            ctx.lineTo(rectx + triangleOffset + triangleEdge, recty+rectHeight + triangleEdge)
            ctx.lineTo(rectx + triangleOffset, recty+rectHeight)
        }

        ctx.lineTo(rectx+radius,recty+rectHeight); // bottom side

        // draw bottom left corner
        ctx.arcTo(rectx,recty + rectHeight,rectx,recty+rectHeight-radius,radius);

        if (balloonDirection === BalloonCanvas.BalloonDirection.Left) {
            ctx.lineTo(rectx , recty + triangleOffset + triangleEdge * 2)
            ctx.lineTo(rectx - triangleEdge, recty + triangleOffset + triangleEdge)
            ctx.lineTo(rectx, recty + triangleOffset)
        }

        ctx.lineTo(rectx,recty + radius);            // left side
        // draw top left corner
        ctx.arcTo(rectx,recty,rectx + radius,recty,radius);

        ctx.closePath();
        if (canvas.fill)
            ctx.fill();
        if (canvas.stroke)
            ctx.stroke();
        ctx.restore();
    }

    Item {
        id: content

        anchors.fill: canvas
        anchors.leftMargin: canvas.contentMargin + canvas.offsetX
        anchors.rightMargin: canvas.contentMargin
        anchors.topMargin: canvas.contentMargin
        anchors.bottomMargin: canvas.contentMargin + canvas.offsetY
    }
}
