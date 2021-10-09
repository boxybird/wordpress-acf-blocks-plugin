<template>
  <div>
    <h1>{{ block.title }}</h1>
    <Message />
  </div>
</template>

<script>
import Message from './components/Message.vue'

export default {
  name: 'Vue Component Example',
  props: ['block'],
  components: {
    Message,
  },
}
</script>

<style></style>
