<?php

/**
 * JSON encode array data in HTML element.
 *
 * Example: '<div data-block="<?= bb_json_encode($data); ?>"></div>'
 */
if (!function_exists('bb_json_encode')) {
    function bb_json_encode(array $data)
    {
        return htmlspecialchars(json_encode($data, true), ENT_QUOTES, 'UTF-8');
    }
}
