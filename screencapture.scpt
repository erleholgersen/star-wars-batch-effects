set video to "PATH_TO_VIDEO"

tell application "VLC" to activate
    tell application "VLC" to open video
    
    tell application "VLC" 
        set elapsed to current time
        set tMax to duration of current item
    end tell
    
    repeat while elapsed < tMax 
        tell application "VLC"
            repeat 6 times
                step forward
            end repeat
            set elapsed to current time
        end tell
        tell application "System Events" 
            keystroke "s" using {command down, option down}
        end tell
    end repeat
