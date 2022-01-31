<?php

add_action('acf/init', function () {
    acf_register_block_type([
        'name'            => 'bb-acf-php-js-example',
        'title'           => __('BoxyBird Php Js Example Block'),
        'description'     => __('A custom Php Js Example block.'),
        'category'        => 'bb-acf-blocks',
        'icon'            => 'block-default',
        'keywords'        => ['php-js-example, boxybird'],
        'render_template' => __DIR__ . '/../template.php',
        'enqueue_assets'  => function () {
            $version = md5(file_get_contents(BB_ACF_BLOCKS__PLUGIN_DIR . 'dist/mix-manifest.json'));

            wp_enqueue_script('bb-acf-blocks', BB_ACF_BLOCKS__PLUGIN_URL . 'dist/bb-acf-blocks.js', [], $version, true);
        },
    ]);
});
