<?php

add_action('acf/init', function () {
    acf_register_block_type([
        'name'            => 'bb-acf-vue-example',
        'title'           => __('BoxyBird Vue Example Block'),
        'description'     => __('A custom Vue Example block.'),
        'category'        => 'bb-acf-blocks',
        'icon'            => 'block-default',
        'keywords'        => ['vue-example, boxybird'],
        'enqueue_assets'  => function () {
            $version = md5(file_get_contents(BB_ACF_BLOCKS__PLUGIN_DIR . 'dist/mix-manifest.json'));

            wp_enqueue_script('bb-acf-blocks', BB_ACF_BLOCKS__PLUGIN_URL . 'dist/bb-acf-blocks.js', [], $version, true);
        },
        'render_callback' => function ($block) {
            $data = [
                'title'   => 'Vue Example',
            ];

            echo '<div id="' . $block['id'] . '" class="bb-acf-vue-example" data-block="' . bb_json_encode($data) . '"></div>';
        },
    ]);
});
