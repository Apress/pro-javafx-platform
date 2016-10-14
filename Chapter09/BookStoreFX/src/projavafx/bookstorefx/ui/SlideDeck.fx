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
 */
package projavafx.bookstorefx.ui;

import javafx.animation.Timeline;
import javafx.lang.Duration;
import javafx.scene.layout.Container;
import projavafx.bookstorefx.ui.SlideDeck.TimelineTracker;

/**
 * This is a special case of Deck that has slideshow functionality.  It only shows one Node, or slide,
 * from the deck at a time and allows you to define animated transitions for each slide.  When the
 * <code>slideIndex</code> is updated:
 *
 * 1. The old slide's out transition will play (if defined).
 * 2. The old slide will be made invisible.
 * 3. The new slide will be made visible.
 * 4. The new slide's in transition will play (if defined).
 *
 * So if you want your slide to fade out, just define a <code>Timeline</code> that animates the slide
 * node's opacity value to 0.
 *
 * @author Dean Iverson
 */
public class SlideDeck extends Container {
    init {
        for (i in [1..<sizeof content]) {
            content[i].visible = false;
        }
    }

    public var inTransitions: Timeline[];
    public var outTransitions: Timeline[];

    public var slideIndex: Integer on replace oldValue {
        if (oldValue != slideIndex) {
            lastSlideIndex = oldValue;
            if (lastSlideIndex < sizeof outTransitions) {
                timelineTracker.timeline = outTransitions[lastSlideIndex];
                timelineTracker.onTimelineStopped = function() {
                    transition( lastSlideIndex, slideIndex );
                }
                timelineTracker.enabled = true;
                outTransitions[lastSlideIndex].playFromStart();
            } else {
                transition( lastSlideIndex, slideIndex );
            }
        }
    }

    var timelineTracker = TimelineTracker{
    }
    var lastSlideIndex: Integer;

    override var content on replace {
        if (slideIndex >= sizeof content) {
            slideIndex = sizeof content - 1;
        }
    }

    function transition( fromIndex:Integer, toIndex:Integer) {
        //println( "transition {fromIndex} to {toIndex}" );
        timelineTracker.enabled = false;
        content[fromIndex].visible = false;
        content[toIndex].visible = true;

        if (toIndex < sizeof inTransitions) {
            inTransitions[toIndex].playFromStart();
        }
    }
}

class TimelineTracker {
    public var timeline: Timeline;
    public var onTimelineStarted: function();
    public var onTimelineStopped: function();
    public var onTimeChanged: function( time:Duration );
    public var enabled = true;

    var isRunning = bind timeline.running on replace wasRunning {
        if (enabled and isRunning != wasRunning) {
            if (wasRunning == true and isRunning == false) {
                onTimelineStopped();
            } else {
                onTimelineStarted();
            }
        }
    }

    var time = bind timeline.time on replace {
        if( enabled )
        onTimeChanged( time );
    }
}
