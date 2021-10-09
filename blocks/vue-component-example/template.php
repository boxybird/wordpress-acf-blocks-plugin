<?php

$data = [
    'title' => 'Vue Component Example'
];
?>

<div id="<?= $block['id']; ?>" class="bb-acf-vue-component-example" data-block="<?= bb_json_encode($data); ?>"></div>
