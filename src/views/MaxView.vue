<script setup>
import { computed, onMounted, ref } from 'vue'

// Declarative rendering: the greeting is described in the template from this state
const name = ref('Max')
const greeting = computed(() => {
  const trimmed = name.value.trim()
  return trimmed ? `Hello, ${trimmed}!` : 'Hello! Type your name above.'
})

// Reactivity: changing count updates everything that depends on it
const count = ref(0)
const doubled = computed(() => count.value * 2)

function increment() {
  count.value++
}

function decrement() {
  count.value--
}

function reset() {
  count.value = 0
}

onMounted(() => {
  console.log(`The initial count is ${count.value}.`)
})
</script>

<template>
  <div class="student-page">
    <header class="intro">
      <h1>Max's page</h1>
      <p class="subtitle">Introduction to Vue 3: a progressive JavaScript framework</p>
    </header>

    <section class="card">
      <h2>Declarative rendering</h2>
      <p class="hint">Extends HTML to describe output based on JavaScript state.</p>
      <label class="field">
        Your name
        <input v-model="name" type="text" autocomplete="off" />
      </label>
      <p class="result" aria-live="polite">{{ greeting }}</p>
    </section>

    <section class="card">
      <h2>Reactivity</h2>
      <p class="hint">Vue tracks state changes and updates the DOM automatically.</p>
      <p class="result" aria-live="polite">Count is: {{ count }} (doubled: {{ doubled }})</p>
      <div class="buttons">
        <button type="button" @click="decrement">-1</button>
        <button type="button" class="primary" @click="increment">+1</button>
        <button type="button" :disabled="count === 0" @click="reset">Reset</button>
      </div>
    </section>

    <p class="footnote">Built as a single-file component with the Composition API.</p>
  </div>
</template>

<style scoped>
.student-page {
  max-width: 640px;
  margin: 0 auto;
  padding: 24px 8px 40px;
  text-align: center;
}

h1 {
  margin: 0;
  font-size: 2.25rem;
}

h2 {
  margin: 0 0 6px;
  font-size: 1.25rem;
}

.subtitle {
  margin: 8px 0 24px;
  color: #5b6b7b;
}

.card {
  margin-bottom: 16px;
  padding: 20px;
  border: 1px solid #e1e6ec;
  border-radius: 12px;
  background: #fff;
}

.hint {
  margin: 0 0 16px;
  color: #5b6b7b;
  font-size: 0.95rem;
}

.field {
  display: inline-flex;
  align-items: center;
  flex-wrap: wrap;
  justify-content: center;
  gap: 8px;
  font-weight: 600;
}

.field input {
  padding: 8px 10px;
  border: 1px solid #c8d1da;
  border-radius: 8px;
  font: inherit;
  font-weight: 400;
}

.result {
  margin: 16px 0;
  color: #2f8f68;
  font-size: 1.25rem;
  font-weight: 700;
}

.buttons {
  display: flex;
  justify-content: center;
  gap: 8px;
}

button {
  padding: 8px 16px;
  border: 1px solid #c8d1da;
  border-radius: 8px;
  background: #fff;
  color: inherit;
  font: inherit;
  cursor: pointer;
}

button:hover:not(:disabled) {
  background: #f1f4f7;
}

button:disabled {
  cursor: default;
  opacity: 0.5;
}

button.primary {
  border-color: #2f8f68;
  background: #2f8f68;
  color: #fff;
}

button.primary:hover {
  background: #27775a;
}

.footnote {
  margin: 24px 0 0;
  color: #5b6b7b;
  font-size: 0.85rem;
}
</style>
