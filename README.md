## Installation

Clone or download the plugin and run `npm install && npm run dev`.

## Scaffold Block

`sh scaffold-block.sh`

> Usage:

```bash
$ sh scaffold-block.sh
Block name?
foo-block

Template type?
1) PHP/Vanilla JS
2) Alpine
3) Vue (Inline Template)
4) Vue (Component)
#? 2
```

> Examples of each block found in ./blocks

## Watch Files

`npm run watch`

_If you scaffold a new block, you must stop and restart watcher._

## Production

`npm run build`

## Notes
This is a starter plugin I built for my own use. Feel free to customize it to your needs.

My goal was to have a way to quickly create new ACF blocks to extend functionality of a custom theme.

You'll notice there is styling solution for each block. I tend to have all styles contained within the theme.

### Other helpful places to look
```dotnetcli
/inc/setup.php
/inc/enqueue.php
```