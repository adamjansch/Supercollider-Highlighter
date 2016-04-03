Supercollider Highlighter
=========================

**Supercollider Highlighter** is a PHP library that applies syntax colour-coding to Supercollider code files for presentation on the web. It was designed for the <a href="http://www.adamjansch.co.uk/sc-a-day/" title="Supercollider a day" target="_blank">Supercollider a day project</a> and is based on code from Scott Hewitt’s <a href="http://www.ablelemon.co.uk/chuckhl" title="ChucK Highlighter" target="_blank">ChucK Highlighter</a>.

<div id="intro-end"></div>

Usage
-----

1. Copy 'sc_highlighting.php' (and optionally 'sc_highlighting.css') to your directory.
2. If using 'sc_highlighting.css', call `sc_add_stylesheet()` to add the formatting stylesheet. Use a string as the argument to add a prepath.
3. Call `sc_highlight_string()` to highlight a PHP string or `sc_highlight_file()` to highlight a text file. With the latter, use the path to your Supercollider code file as the argument. Code will be placed within `<pre>` tags automatically.

Change log
----------
* 0.9.4: Added `sc_highlight_string()` and `sc_highlight_file()` functions to replace `sc_highlighter()` – these functions return a highlighted string rather than echoing directly.
* 0.9.3: Fixed improper colouring of keywords within other words.
* 0.9.2: Colouring of |arg declarations| added.
* 0.9.1: `sc_add_stylesheet()` function added.
* 0.9.0: First release.