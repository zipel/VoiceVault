using Toybox.WatchUi as WatchUi;
using Toybox.Graphics as Graphics;
using Toybox.System as System;

class VoiceVaultApp extends WatchUi.Application {
    hidden var _mainView;
    function initialize() {
        WatchUi.Application.initialize();
        _mainView = new MainView();
    }
    function onStart() {
        _mainView:show(true);
    }
}

class MainView extends WatchUi.View {
    hidden var _recorder = null;
    function onShow() {
        _recorder = new Recorder();
    }
    function onHide() { }
    function onUpdate(dc) {
        dc:clear();
        dc:setColor(Graphics.COLOR_WHITE);
        dc:drawText(10, 20, "VoiceVault", Graphics.FONT_MEDIUM);
        if (_recorder != null && _recorder:isRecording()) {
            dc:drawText(10, 60, "Recording...", Graphics.FONT_SMALL);
        } else {
            dc:drawText(10, 60, "Tap select to record", Graphics.FONT_SMALL);
        }
    }
    function onKey(key) {
        if (key == WatchUi.KEY_SELECT && _recorder != null) {
            if (!_recorder:isRecording()) {
                System.println("VoiceVault: starting recording");
                _recorder:start();
            } else {
                System.println("VoiceVault: stopping recording");
                _recorder:stop();
            }
            requestUpdate();
        }
    }
}
