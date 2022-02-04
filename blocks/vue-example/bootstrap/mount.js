import { createApp } from 'vue'
import Block from '../Block.vue'

const mount = (el) => {
  createApp(Block, {
    block: JSON.parse(el.dataset.block),
  }).mount(el)
}

if (window.acf) {
  window.acf.addAction('render_block_preview/type=bb-acf-vue-example', (el) => {
    mount(el[0].querySelector('[id^=block_].bb-acf-vue-example'))
  })
} else {
  let els = document.querySelectorAll('[id^=block_].bb-acf-vue-example')

  els.forEach((el) => {
    mount(el)
  })
}
