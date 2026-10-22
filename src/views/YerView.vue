<template>
  <div class="student-page">
    <h1>Yerdos</h1>
    <p>This is my first Vue page for the Kaza group.</p>

    <h2>Counter</h2>
    <p aria-live="polite">Count: {{ count }}</p>
    <div class="buttons">
      <button type="button" :disabled="count === 0" @click="count--">-1</button>
      <button type="button" @click="count++">+1</button>
      <button type="button" @click="count = 0">Reset</button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'YerView',
  data() {
    return {
      count: 0,
    }
  },
}
</script>

<style scoped>
.student-page {
  max-width: 720px;
  margin: 0 auto;
  padding: 24px 8px;
  text-align: center;
}

h2 {
  margin-top: 32px;
}

.buttons {
  display: flex;
  justify-content: center;
  gap: 8px;
}

button {
  padding: 8px 16px;
  font: inherit;
  cursor: pointer;
}

button:disabled {
  cursor: default;
}
</style>
