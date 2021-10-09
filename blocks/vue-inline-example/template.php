<?php

$data = [
    'title' => 'Vue Inline Example'
];
?>

<div id="<?= $block['id']; ?>" class="bb-acf-vue-inline-example" data-block="<?= bb_json_encode($data); ?>">
    <h1>{{ block.title }}</h1>
    <h3>(Go add some ACF's)</h3>
</div>
