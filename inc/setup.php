<?php

/**
 * Register a new block category.X
 */
add_filter('block_categories', function ($default_categories, $post) {
    array_unshift($default_categories, [
        'slug'  => 'bb-acf-blocks',
        'title' => 'BoxyBird ACF Blocks',
    ]);

    return $default_categories;
}, 10, 2);

/**
 * A filter to add markup wrapper around blocks.
 * Helpful for styling core/third-party blocks with TailwindCSS.
 */
add_filter('render_block', function ($block_content, $block) {
    if (substr($block['blockName'], 0, 10) === 'acf/bb-acf') {
        return $block_content;
    }

    // Array of block names to add wrapper to.
    $should_wrap = [
        // 'core/list',
        // 'core/paragraph',
        // 'some-third-party/content',
    ];

    if (in_array($block['blockName'], $should_wrap)) {
        $block_content = '<div class="prose max-w-full"><div>' . $block_content . '</div></div>';
    };

    return $block_content;
}, 10, 2);
