import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Layouts

ShellRoot {

  PanelWindow {
    id: mainpanel
    anchors {
      top: true
      left: true
      right: true
    }
    margins {
      bottom: -5
      top: 7
    }
    color: "transparent"

    // keep the reserved bar space fixed even while the pill grows
    // downward for the launcher, so other windows don't get pushed
    exclusiveZone: 35

    // only steal keyboard focus while an interactive module is open
    WlrLayershell.keyboardFocus: (pill.showLauncher || pill.showWallpaper)
      ? WlrKeyboardFocus.Exclusive
      : WlrKeyboardFocus.None

    // NOTE: no Behavior here — pill.implicitHeight already animates
    // itself below. Animating this too meant the panel was chasing
    // a constantly-moving target every frame, which is what caused
    // the glitchy/rubber-band feel. Panel just tracks the pill 1:1.
    implicitHeight: pill.implicitHeight + 14

    // bind in hyprland.lua: hl.dsp.exec_cmd("qs ipc call launcher toggle")
    //
    // Debounced: if your keybind or IPC caller ever fires twice in quick
    // succession (key repeat, double-bound key, etc.), this ignores the
    // second call instead of letting it flip the launcher straight back
    // shut — that's what the open->close->reopen flicker in your
    // recording was.
    IpcHandler {
      target: "launcher"
      function toggle(): void {
        if (toggleDebounce.running) return
        toggleDebounce.restart()
        pill.showWallpaper = false
        pill.showLauncher = !pill.showLauncher
      }
      function show(): void { pill.showLauncher = true }
      function hide(): void { pill.showLauncher = false }
    }

    IpcHandler {
      target: "wallpaper"
      function toggle(): void {
        if (toggleDebounce.running) return
        toggleDebounce.restart()
        pill.showLauncher = false
        pill.showWallpaper = !pill.showWallpaper
      }
      function show(): void { pill.showWallpaper = true }
      function hide(): void { pill.showWallpaper = false }
    }

    Timer {
      id: toggleDebounce
      interval: 150
      repeat: false
    }

    RowLayout {
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter

      Rectangle {
        id: pill
        color: "black"
        radius: (showLauncher || showWallpaper) ? 30 : 99

        implicitWidth: showLauncher
          ? (launcherLoader.item ? launcherLoader.item.implicitWidth + 18 : 420)
          : showWallpaper
            ? (wallpaperLoader.item ? wallpaperLoader.item.implicitWidth + 18 : 760)
            : content.implicitWidth + 70
        implicitHeight: showLauncher
          ? (launcherLoader.item ? launcherLoader.item.implicitHeight + 22 : 60)
          : showWallpaper
            ? (wallpaperLoader.item ? wallpaperLoader.item.implicitHeight + 22 : 145)
            : content.implicitHeight + 14

        property bool showLauncher: false
        property bool showWallpaper: false
        property bool showWorkspaces: revealTimer.running

        // single source of animation for the pill — nothing inside
        // LauncherContent animates its own size, so this is the only
        // thing moving, which is what keeps it smooth instead of jittery
        Behavior on implicitWidth {
          NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
        Behavior on implicitHeight {
          NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
        Behavior on radius {
          NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }

        // fires the workspace reveal, but not while the launcher is open
        Connections {
          target: Hyprland
          function onFocusedWorkspaceChanged() {
            if (!pill.showLauncher && !pill.showWallpaper) revealTimer.restart()
          }
        }

        Timer {
          id: revealTimer
          interval: 1000
          running: false
          repeat: false
        }

        // clock / workspace content
        Item {
          id: content
          anchors.centerIn: parent
          visible: !pill.showLauncher && !pill.showWallpaper
          implicitWidth: pill.showWorkspaces ? wsLoader.implicitWidth : label.implicitWidth
          implicitHeight: pill.showWorkspaces ? wsLoader.implicitHeight : label.implicitHeight

          Text {
            id: label
            anchors.centerIn: parent
            visible: !pill.showWorkspaces
            text: Qt.formatDateTime(clock.date, "hh:mm")
            color: "#e8eaed"
            font {
              family: "SF Pro Display"
              pixelSize: 16
              weight: 800
            }

            SystemClock {
              id: clock
              precision: SystemClock.minutes
            }
          }

          Loader {
            id: wsLoader
            anchors.centerIn: parent
            active: pill.showWorkspaces
            visible: pill.showWorkspaces
            source: "Workspaces.qml"
          }
        }

        // launcher content — grows out of the same pill, sized by
        // LauncherContent's own implicitWidth/implicitHeight (which
        // shrink dynamically with the result count). Anchored to the
        // TOP (not centered) so the search bar's position never moves
        // as the list below it grows or shrinks.
        Loader {
          id: launcherLoader
          anchors.top: parent.top
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.topMargin: 10
          anchors.bottomMargin: 6
          active: pill.showLauncher
          visible: pill.showLauncher
          source: "LauncherContent.qml"

          onLoaded: item.closeRequested.connect(function() {
            pill.showLauncher = false
          })
        }

        // wallpaper switcher — same pill, opened through:
        // qs ipc call wallpaper toggle
        Loader {
          id: wallpaperLoader
          anchors.top: parent.top
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.topMargin: 10
          anchors.bottomMargin: 6
          active: pill.showWallpaper
          visible: pill.showWallpaper
          source: "wallpaper_switcher.qml"

          onLoaded: item.closeRequested.connect(function() {
            pill.showWallpaper = false
          })
        }
      }
    }
  }
}
