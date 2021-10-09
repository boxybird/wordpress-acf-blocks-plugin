let mix = require('laravel-mix')

mix
  .setPublicPath('dist')
  .js('src/js/vue.js', 'bb-acf-blocks.js')
  .js('src/js/alpine.js', 'bb-acf-blocks.js')
  .js('blocks/**/bootstrap/mount.js', 'bb-acf-blocks.js')
  .vue()
  .version()
