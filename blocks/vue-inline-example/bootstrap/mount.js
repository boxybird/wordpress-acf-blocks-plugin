import block from '../block'
import { createApp } from 'vue'

const mount = (el) => {
  createApp(block, {
    block: JSON.parse(el.dataset.block),
  }).mount(el)
}

if (window.acf) {
  window.acf.addAction('render_block_preview/type=bb-acf-vue-inline-example', (el) => {
    mount(el[0].querySelector('[id^=block_].bb-acf-vue-inline-example'))
  })
} else {
  let els = document.querySelectorAll('[id^=block_].bb-acf-vue-inline-example')

  els.forEach((el) => {
    mount(el)
  })
}
