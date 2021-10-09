<?php

$title = 'Alpine Example';
?>

<div id="<?= $block['id']; ?>" class="bb-acf-alpine-example" x-data="{
    title: '<?= $title ?>'
}">
    <h1 x-text="title"></h1>
    <h3>(Go add some ACF's)</h3>
</div>
