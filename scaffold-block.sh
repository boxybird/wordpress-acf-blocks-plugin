#!/bin/sh

# Note: Running this script will build a new ACF block

echo -e 'Block name?'

read -e block_name

echo -e '\nTemplate type?'

select block_type in 'PHP/Vanilla JS' 'Vue'
do
  break
done

# create variables
BLOCK_NAME=${block_name}
BLOCK_WORDS=`echo ${BLOCK_NAME^} | sed -r 's/-([a-z])/\U \1/gi'`

BLOCK_TYPE=${block_type}

# create dirs
# ------------------------------------------------------------------------------
mkdir -p 'blocks' && cd './blocks' && mkdir $BLOCK_NAME && cd $BLOCK_NAME && mkdir 'bootstrap'

# create registation file
# ------------------------------------------------------------------------------
if [[ $BLOCK_TYPE == "PHP/Vanilla JS" ]]; then
echo "<?php

add_action('acf/init', function () {
    acf_register_block_type([
        'name'            => 'bb-acf-$BLOCK_NAME',
        'title'           => __('BoxyBird ${BLOCK_WORDS} Block'),
        'description'     => __('A custom $BLOCK_WORDS block.'),
        'category'        => 'bb-acf-blocks',
        'icon'            => 'block-default',
        'keywords'        => ['$BLOCK_NAME, boxybird'],
        'render_template' => __DIR__ . '/../template.php',
        'enqueue_assets'  => function () {
            \$version = md5(file_get_contents(BB_ACF_BLOCKS__PLUGIN_DIR . 'dist/mix-manifest.json'));

            wp_enqueue_script('bb-acf-blocks', BB_ACF_BLOCKS__PLUGIN_URL . 'dist/bb-acf-blocks.js', [], \$version, true);
        },
    ]);
});" > ./bootstrap/register.php
fi

if [[ $BLOCK_TYPE == "Vue" ]]; then
echo "<?php

add_action('acf/init', function () {
    acf_register_block_type([
        'name'            => 'bb-acf-$BLOCK_NAME',
        'title'           => __('BoxyBird ${BLOCK_WORDS} Block'),
        'description'     => __('A custom $BLOCK_WORDS block.'),
        'category'        => 'bb-acf-blocks',
        'icon'            => 'block-default',
        'keywords'        => ['$BLOCK_NAME, boxybird'],
        'enqueue_assets'  => function () {
            \$version = md5(file_get_contents(BB_ACF_BLOCKS__PLUGIN_DIR . 'dist/mix-manifest.json'));

            wp_enqueue_script('bb-acf-blocks', BB_ACF_BLOCKS__PLUGIN_URL . 'dist/bb-acf-blocks.js', [], \$version, true);
        },
        'render_callback' => function (\$block) {
            \$data = [
                'title' => 'Vue Example',
            ];

            echo '<div id=\"' . \$block['id'] . '\" class=\"bb-acf-$BLOCK_NAME\" data-block=\"' . bb_json_encode(\$data) . '\"></div>';
        },
    ]);
});" > ./bootstrap/register.php
fi

# create template file
# ------------------------------------------------------------------------------
if [[ $BLOCK_TYPE == "PHP/Vanilla JS" ]]; then
echo "<?php

\$title = '${BLOCK_WORDS}';
?>

<div id=\"<?= \$block['id']; ?>\" class=\"bb-acf-$BLOCK_NAME\">
    <h1><?= \$title; ?></h1>
    <h3>(Go add some ACF's)</h3>
</div>" > ./template.php
fi

# create mount file
# ------------------------------------------------------------------------------
if [[ $BLOCK_TYPE = "Vue" ]]; then
echo "import { createApp } from 'vue'
import Block from '../Block.vue'

const mount = (el) => {
  createApp(Block, {
    block: JSON.parse(el.dataset.block),
  }).mount(el)
}

if (window.acf) {
  window.acf.addAction('render_block_preview/type=bb-acf-$BLOCK_NAME', (el) => {
      mount(el[0].querySelector('[id^=block_].bb-acf-$BLOCK_NAME'))
    }
  )
} else {
  let els = document.querySelectorAll('[id^=block_].bb-acf-$BLOCK_NAME')

  els.forEach((el) => {
    mount(el)
  })
}" > ./bootstrap/mount.js
fi

if [[ $BLOCK_TYPE = "PHP/Vanilla JS" ]]; then
echo "import block from '../block'

const mount = (el) => {
  block(el)
}

if (window.acf) {
  window.acf.addAction('render_block_preview/type=bb-acf-$BLOCK_NAME', (el) => {
      mount(el[0].querySelector('[id^=block_].bb-acf-$BLOCK_NAME'))
    }
  )
} else {
  let els = document.querySelectorAll('[id^=block_].bb-acf-$BLOCK_NAME')

  els.forEach((el) => {
    mount(el)
  })
}" > ./bootstrap/mount.js
fi

# create block file
# ------------------------------------------------------------------------------
if [[ $BLOCK_TYPE == "PHP/Vanilla JS" ]]; then
echo "export default (el) => {
  // This code is executed when the block
  // is rendered on the front end and in the editor.

  // console.log(el)
}" > ./block.js
fi

if [[ $BLOCK_TYPE = "Vue" ]]; then
echo "<template>
  <div>
    <h1>{{ block.title }}</h1>
    <Message />
  </div>
</template>

<script setup>
import Message from './components/Message.vue'

defineProps({
  block: {
    type: Object,
    required: true,
  },
})
</script>

<style></style>" > ./Block.vue

mkdir 'components' && cd 'components'

echo "<template>
  <h3>{{ message }}</h3>
</template>

<script setup>
const message = '(Go add some ACF\'s)'
</script>

<style></style>"> ./Message.vue
fi
