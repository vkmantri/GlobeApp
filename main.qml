// main.qml
import QtQuick
import QtQuick.Window
import QtQuick3D
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: window
    width: 800
    height: 600
    visible: true
    title: "Qt 6 Globe Viewer"
    color: "#000000"

    View3D {
        id: view
        anchors.fill: parent
        camera: camera

        DirectionalLight {
            id: directionalLight
            color: "#ffffff"
            ambientColor: "#222222"
            position: Qt.vector3d(10, 10, 10)
            eulerRotation: Qt.vector3d(-30, -30, 0)
            castsShadow: true
            brightness: 1.0
        }

        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 0, 500)
        }

        Node {
            id: globeRotator

            Model {
                id: globeModel
                source: "#Sphere"
                scale: Qt.vector3d(5, 5, 5)
                materials: [
                    PrincipledMaterial {
                        id: globeMaterial
                        baseColorMap: Texture {
                            source: "earth_texture.jpg"
                        }
                        metalness: 0.1
                        roughness: 0.6
                        normalMap: Texture {
                            source: "earth_normal.jpg"
                        }
                    }
                ]
            }

            PropertyAnimation {
                target: globeRotator
                property: "eulerRotation.y"
                from: 0
                to: 360
                duration: 30000
                loops: Animation.Infinite
                running: true
            }
        }
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontCenter
        anchors.bottomMargin: 20
        spacing: 10

        Button {
            text: "Rotate Faster"
            onClicked: rotationSlider.value += 0.1
        }

        Slider {
            id: rotationSlider
            from: 0.1
            to: 2.0
            value: 1.0
            onValueChanged: {
                globeRotator.PropertyAnimation.duration = 30000 / value
            }
        }

        Button {
            text: "Rotate Slower"
            onClicked: rotationSlider.value -= 0.1
        }
    }
}
