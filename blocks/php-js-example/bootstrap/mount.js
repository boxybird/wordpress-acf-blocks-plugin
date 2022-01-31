import block from '../block'

const mount = (el) => {
  block(el)
}

if (window.acf) {
  window.acf.addAction('render_block_preview/type=bb-acf-php-js-example', (el) => {
      mount(el[0].querySelector('[id^=block_].bb-acf-php-js-example'))
    }
  )
} else {
  let els = document.querySelectorAll('[id^=block_].bb-acf-php-js-example')

  els.forEach((el) => {
    mount(el)
  })
}
