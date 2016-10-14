/*
 * Copyright (c) 2009, Pro JavaFX Authors
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. Neither the name of JFXtras nor the names of its contributors may be used
 *    to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * Main.fx - Part of the Movie Widget example that illustrates
 * a simple media player that can be run as a desktop widget complete with
 * configuration and skinning support.
 *
 * Developed 2009 by Stephen Chin
 * as a JavaFX Script SDK 1.2 example for the Pro JavaFX book.
 */
package projavafx.moviewidget;

import javafx.scene.media.Media;
import javafx.scene.Scene;
import javafx.scene.control.TextBox;
import javafx.scene.text.Text;
import org.jfxtras.scene.layout.Grid;
import org.jfxtras.scene.layout.LayoutConstants.*;
import org.widgetfx.Widget;
import org.widgetfx.config.Configuration;
import org.widgetfx.config.StringProperty;

/**
 * A simple Movie Widget example that allows the user to play a media file
 * from a URL and supports basic configuration and skinning.
 *
 * @author Stephen Chin
 */
var widget: Widget;
var source = "http://projavafx.com/movies/elephants-dream-640x352.flv"; // only for use with the projavafx samples
def player = SimpleMediaPlayer {
    media: Media {
        source: source
    }
    width: bind widget.width
    height: bind widget.height
} on replace =oldPlayer {
    oldPlayer.player.stop();
}

widget = Widget {
    width: 640
    height: 352
    aspectRatio: bind player.media.width / player.media.height
    content: player
    configuration: Configuration {
        properties: [
            StringProperty {
                name: "source"
                value: bind source with inverse
            }
        ]
        scene: Scene {
            content: Grid {
                rows: row([
                    Text {
                        content: "Source URL:"
                    },
                    TextBox {
                        columns: 30,
                        text: bind source with inverse
                    }
                ])
            }
        }
    }
}
