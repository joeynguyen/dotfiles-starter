# Keyboard shortcuts - movement, editing, history, processes

## Editing

- <kbd>Ctrl+w</kbd> - delete one word backwards
- <kbd>Ctrl+h</kbd> - delete one character backwards
- <kbd>Ctrl+d</kbd> - delete character under the cursor
- <kbd>Ctrl+u</kbd> - delete from cursor to beginning of the line
- <kbd>Ctrl+k</kbd> - delete from cursor to end of the line
- <kbd>Ctrl+y</kbd> - paste previously deleted text
- <kbd>Alt+d</kbd> – delete to end of word starting at cursor (whole word if cursor is at the beginning of word)
- <kbd>Alt+.</kbd> – insert the last word from the previous command
- <kbd>!!</kbd> – run last command (e.g. run the last command as superuser - `sudo !!`)
- <kbd>!blah</kbd> – run the most recent command that starts with ‘blah’ (e.g. `!ls`)
- <kbd>![number]</kbd> – run the command pertaining to the same number referenced in ‘history’ (e.g. `!42`)
- <kbd>^[old_text]^[new_text]</kbd> - replace `old_text` in the previous command with `new_text`

## Movement

- <kbd>Alt+b</kbd> - move one word backwards
- <kbd>Alt+f</kbd> - move one word forward
- <kbd>Ctrl+b</kbd> - move one character backwards
- <kbd>Ctrl+f</kbd> - move one character forward
- <kbd>Ctrl+a</kbd> - move the cursor to the beginning of the line
- <kbd>Ctrl+e</kbd> - move the cursor to the end of the line

## History

- <kbd>Ctrl+p</kbd> - go back to previous command in history (same as Up Arrow)
- <kbd>Ctrl+n</kbd> - go to next command in history (same as Down Arrow)
- <kbd>Ctrl+r</kbd> - type to search history for a command that matches

## Process management

- <kbd>Ctrl+c</kbd> - sends the `SIGINT` signal to interrupt the foreground process.  By default, it should gracefully stop the process.
- <kbd>Ctrl+d</kbd> - exit the shell, similar to the `exit` command
- <kbd>Ctrl+z</kbd> - suspends the current foreground process.  A list of background processes can be seen by typing `jobs`.
  - To put to the process type back into the foreground, `fg [process_name]`, e.g. `fg vim`, or type `fg %[process_number]`, e.g. `fg %1`
  - To resume the suspended job but keep it in the background, type `bg ...`.  This keeps it in the background so you can keep using the command line but you won't be able to interact with it like using <kbd>Ctrl+c</kbd> to kill the command without either putting it in the foreground or typing `kill %[process_number]` / `kill [process_name]`


More shortcuts - https://skorks.com/2009/09/bash-shortcuts-for-maximum-productivity/

