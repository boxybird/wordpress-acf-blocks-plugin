<template>
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

<style></style>
