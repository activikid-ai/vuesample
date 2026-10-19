<template>
  <div class="title-page">
    <h1>{{ title }}</h1>
  </div>
</template>

<script>
export default {
  name: 'TitleView',
  props: {
    title: {
      type: String,
      required: true,
    },
  },
}
</script>

<style scoped>
.title-page {
  padding: 48px 16px;
  text-align: center;
}

h1 {
  margin: 0;
  font-size: 2.5rem;
  color: #2c3e50;
  text-transform: uppercase;
  letter-spacing: 0.08em;
}
</style>
