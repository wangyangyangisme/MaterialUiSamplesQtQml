
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
Item {
    anchors.fill: parent
    id:root
    property bool switchState: false
    property bool downAnim: true
    Rectangle{
        id:backgroundRect
        anchors.fill: parent
        color:"white"

        Rectangle{
            id:tempRect
anchors.centerIn: parent
width:0
height: width
radius: width/2
color:switchState?Material.color(Material.Blue):"white"


NumberAnimation{
target: tempRect
id:changeBackground
alwaysRunToEnd: true
property:"width"
running: false
from:0
to :root.height*2
duration: 1400
onStopped:
{
    backgroundRect.color=switchState?Material.color(Material.Blue):"white"
    tempRect.opacity=0
    downAnim=true


}
}
        }
        Rectangle{
            id:subRect
            anchors.centerIn: parent
            width: (parent.width*2)/5
            height: (parent.height)/20
            radius: width/2
            color:Material.color(Material.Blue)

            ColorAnimation on color{
                id:colorsubAnim
                alwaysRunToEnd: true

                running:false
                to: !switchState?"white":Material.color(Material.Blue)
                duration: 500
            }



            Rectangle{
                id:switchKey
                x:0
                anchors.verticalCenter: parent.verticalCenter
                width: (backgroundRect.height)/10
                height: width
                radius: width/2
                color:Material.color(Material.Blue)
                ColorAnimation on color{
                    id:colorswitchAnim
                    alwaysRunToEnd: true

                    running:false
                    to:!switchState? "white" :Material.color(Material.Blue)
                    duration: 700
                }
                NumberAnimation{
                    id:moveAnimation
                    target:   switchKey
                    alwaysRunToEnd: true

                    property: "x"
                    to:!switchState?(subRect.width ) - switchKey.width :0
                    duration: 700
                }

                SequentialAnimation {
                    alwaysRunToEnd: true

                    running: false
                    id:changeSize
                    NumberAnimation{
                        target:   switchKey
                        property: "width"
                        to:switchKey.width*1.5
                        duration: 350
                    }
                    NumberAnimation{
                        target:   switchKey
                        property: "width"
                        to:switchKey.width
                        duration: 350
                    }

                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(switchState && downAnim){
                        downAnim=false
                    moveAnimation.start()
                    colorsubAnim.start()
                    colorswitchAnim.start()
                    changeSize.start()
                    tempRect.opacity=true
                    changeBackground.start()

                        switchState=false
                    }
                    else if(  !switchState &&downAnim)
                    {
                        downAnim=false

                        moveAnimation.start()
                        colorsubAnim.start()
                        colorswitchAnim.start()
                       changeSize.start()
                        tempRect.opacity=true
                        changeBackground.start()
                        switchState=true

                    }
                }
            }
        }
    }
}