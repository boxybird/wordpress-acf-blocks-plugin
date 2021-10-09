#!/bin/sh

# Note: Running this script will build a new ACF block

echo -e 'Block name?'

read -e block_name

echo -e '\nTemplate type?'

select block_type in 'PHP/Vanilla JS' 'Alpine' 'Vue (Inline Template)' 'Vue (Component)'
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
if [[ $BLOCK_TYPE == "Alpine" ]]; then
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
else
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

# create template file
# ------------------------------------------------------------------------------
if [[ $BLOCK_TYPE == "Alpine" ]]; then
echo "<?php

\$title = '${BLOCK_WORDS}';
?>

<div id=\"<?= \$block['id']; ?>\" class=\"bb-acf-$BLOCK_NAME\" x-data=\"{
    title: '<?= \$title ?>'
}\">
    <h1 x-text=\"title\"></h1>
    <h3>(Go add some ACF's)</h3>
</div>" > ./template.php
fi

if [[ $BLOCK_TYPE == "Vue (Inline Template)" ]]; then
echo "<?php

\$data = [
    'title' => '${BLOCK_WORDS}'
];
?>

<div id=\"<?= \$block['id']; ?>\" class=\"bb-acf-$BLOCK_NAME\" data-block=\"<?= bb_json_encode(\$data); ?>\">
    <h1>{{ block.title }}</h1>
    <h3>(Go add some ACF's)</h3>
</div>" > ./template.php
fi

if [[ $BLOCK_TYPE == "Vue (Component)" ]]; then
echo "<?php

\$data = [
    'title' => '${BLOCK_WORDS}'
];
?>

<div id=\"<?= \$block['id']; ?>\" class=\"bb-acf-$BLOCK_NAME\" data-block=\"<?= bb_json_encode(\$data); ?>\"></div>" > ./template.php
fi

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
if [[ $BLOCK_TYPE == "Vue (Inline Template)" ]]; then
echo "import block from '../block'
import { createApp } from 'vue'

const mount = (el) => {
  createApp(block, {
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

if [[ $BLOCK_TYPE = "Vue (Component)" ]]; then
echo "import block from '../block'
import { createApp } from 'vue'

const mount = (el) => {
  createApp(block, {
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
if [[ $BLOCK_TYPE == "Vue (Inline Template)" ]]; then
echo "export default {
  name: '$BLOCK_WORDS',
  props: ['block']
}" > ./block.js
fi

if [[ $BLOCK_TYPE = "Vue (Component)" ]]; then
echo "<template>
  <div>
    <h1>{{ block.title }}</h1>
    <Message />
  </div>
</template>

<script>
import Message from './components/Message.vue'

export default {
  name: '$BLOCK_WORDS',
  props: ['block'],
  components: {
    Message,
  },
}
</script>

<style></style>" > ./Block.vue

mkdir 'components' && cd 'components'

echo "<template>
  <h3>{{ message }}</h3>
</template>

<script>
export default {
  name: 'Message Component',

  data() {
    return {
      message: \"(Go add some ACF's)\",
    }
  },
}
</script>

<style></style>"> ./Message.vue
fi

if [[ $BLOCK_TYPE == "PHP/Vanilla JS" ]]; then
echo "export default (el) => {
  // This code is executed when the block
  // is rendered on the front end and in the editor.

  // console.log(el)
}" > ./block.js
fi
