<?php

/**
 * Plugin Name: BoxyBird ACF Blocks
 * Description: A starter plugin to create ACF Pro powered blocks using Vue, Alpine.js, or Vanilla Javascript.
 * Version:     3.0.0
 * Author:      Andrew Rhyand
 * Author URI:  https://andrewrhyand.com
 * License:     MIT
 */

if (!defined('ABSPATH')) {
    exit;
}

define('BB_ACF_BLOCKS__FILE', __FILE__);
define('BB_ACF_BLOCKS__PLUGIN_URL', plugin_dir_url(__FILE__));
define('BB_ACF_BLOCKS__PLUGIN_DIR', plugin_dir_path(__FILE__));

// Plugin registration hook
register_activation_hook(__FILE__, function () {
    if (!function_exists('acf_register_block_type')) {
        die('Plugin requires ACF Pro');
    }
});

/**
 * Require includes
 */
foreach (glob(BB_ACF_BLOCKS__PLUGIN_DIR . 'inc/*.php') as $file) {
    require_once $file;
}

/**
 * Require ACF blocks
 */
foreach (glob(BB_ACF_BLOCKS__PLUGIN_DIR . 'blocks/**/bootstrap/register.php') as $file) {
    require_once $file;
}
