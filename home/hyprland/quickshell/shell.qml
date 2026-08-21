import Quickshell
import QtQuick
import Quickshell.Hyprland
import Quickshell.Services.UPower

ShellRoot {
    PanelWindow {
        id: qsbar
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 43
        property color backgroundColor: "#202020"

        Row {
            anchors.fill: parent

            Rectangle {
                width: parent.width / 3
                height: parent.height
                color: Qt.lighter(qsbar.backgroundColor, 1.2)

                Row {
                    anchors.centerIn: parent
                    spacing: 10

                    Repeater {
                        model: 10

                        delegate: Rectangle {
                            id: wsRect

                            width: parent.parent.width / 10.5 - 10.5
                            height: 20
                            color: isActive ? "#909060" : isOccupied ? "#707070" : "#505050"
                            radius: 5

                            Behavior on color {
                                ColorAnimation {
                                    duration: 180
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                color: "white"
                                text: parent.wsId
                                font.pixelSize: 12
                                font.family: "monospace"
                            }

                            required property int index
                            readonly property int wsId: index + 1
                            readonly property bool isActive: Hyprland.focusedWorkspace.id === wsId
                            readonly property bool isOccupied: findWorkspace(wsId) !== null

                            function findWorkspace(id) {
                                const list = Hyprland.workspaces.values;
                                for (let i = 0; i < list.length; i++) {
                                    if (list[i].id === id)
                                        return list[i];
                                }
                                return null;
                            }
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width / 3
                height: parent.height
                color: qsbar.backgroundColor

                Text {
                    anchors.centerIn: parent
                    color: "white"
                    text: Qt.formatTime(new Date(), "HH:mm")
                }
            }

            Rectangle {
                width: parent.width / 3
                height: parent.height
                color: Qt.darker(qsbar.backgroundColor, 1.2)

                Rectangle {
                    id: batteryBar
                    anchors.centerIn: parent
                    width: 60
                    height: 20
                    radius: 10
                    property int percentage: UPower.displayDevice.percentage * 100
                    color: "transparent"

                    border.color: percentage > 20 ? "green" : percentage > 10 ? "#995500" : "#aa0000"
                    border.width: 2

                    Item {
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }
                        width: batteryBar.width
                        clip: true
                        Rectangle {
                            height: parent.height
                            width: parent.width * batteryBar.percentage / 100
                            color: batteryBar.percentage > 20 ? "green" : batteryBar.percentage > 10 ? "#995500" : "#aa0000"
                        }
                    }
                }
            }
        }
    }
}
