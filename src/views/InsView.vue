<template>
  <main class="student-page">
    <section class="intro">
      <p class="eyebrow">A tiny interactive demo</p>
      <h1>Introduction to Vue 3</h1>
      <p class="subtitle">A progressive JavaScript framework for building user interfaces.</p>
    </section>

    <section class="info-card">
      <h2>What is Vue?</h2>
      <p>
        Vue is a JavaScript framework for building user interfaces.
        It helps connect the data in an app to what appears on the screen.
      </p>
    </section>

    <section class="features">
      <article class="info-card">
        <span class="feature-number">01</span>
        <h2>Declarative rendering</h2>
        <p>Describe what the page should show, and Vue renders it for you.</p>
      </article>

      <article class="info-card">
        <span class="feature-number">02</span>
        <h2>Reactivity</h2>
        <p>When the data changes, Vue updates the page automatically.</p>
      </article>
    </section>

    <section class="counter-card">
      <p class="eyebrow">Try reactivity</p>
      <h2>Vue Counter</h2>
      <p class="counter-value" aria-live="polite">{{ count }}</p>
      <div class="buttons">
        <button type="button" @click="decrement">−</button>
        <button type="button" class="primary" @click="increment">Add one</button>
        <button type="button" @click="reset">Reset</button>
      </div>
      <p class="hint">Click a button and watch the number update.</p>
    </section>

    <footer>Built with Vue 3 · Ins</footer>
  </main>
</template>

<script>
export default {
  name: 'InsView',
  data() {
    return {
      count: 0,
    }
  },
  methods: {
    increment() {
      this.count++
    },
    decrement() {
      this.count--
    },
    reset() {
      this.count = 0
    },
  },
  mounted() {
    console.log(`The initial count is ${this.count}.`)
  },
}
</script>

<style scoped>
.student-page {
  max-width: 850px;
  margin: 0 auto;
  padding: 48px 24px;
  color: #17233b;
  font-family: Arial, sans-serif;
}

.intro {
  margin-bottom: 28px;
  padding: 36px;
  border-radius: 20px;
  background: linear-gradient(135deg, #e9f8f5, #eef1ff);
  text-align: center;
}

.eyebrow {
  margin: 0 0 10px;
  color: #397b70;
  font-size: 0.8rem;
  font-weight: 700;
  letter-spacing: 0.12em;
  text-transform: uppercase;
}

h1 {
  margin: 0;
  font-size: clamp(2rem, 6vw, 3.2rem);
}

.subtitle {
  margin: 14px 0 0;
  color: #596579;
  font-size: 1.05rem;
}

.info-card,
.counter-card {
  padding: 24px;
  border: 1px solid #e3e8ef;
  border-radius: 16px;
  background: #fff;
  box-shadow: 0 8px 24px rgb(23 35 59 / 6%);
}

.info-card h2,
.counter-card h2 {
  margin: 8px 0;
}

.info-card p,
.hint {
  color: #657187;
  line-height: 1.6;
}

.features {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 16px;
  margin: 16px 0;
}

.feature-number {
  color: #48a08d;
  font-size: 0.8rem;
  font-weight: 700;
}

.counter-card {
  margin-top: 16px;
  text-align: center;
}

.counter-value {
  margin: 12px 0;
  color: #397b70;
  font-size: 4rem;
  font-weight: 700;
}

.buttons {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 10px;
}

button {
  padding: 10px 16px;
  border: 1px solid #d4dce7;
  border-radius: 10px;
  background: #fff;
  color: #17233b;
  cursor: pointer;
  font: inherit;
}

button:hover {
  background: #f1f5f8;
}

button.primary {
  border-color: #397b70;
  background: #397b70;
  color: #fff;
}

button.primary:hover {
  background: #2d655c;
}

footer {
  padding-top: 28px;
  color: #8490a2;
  text-align: center;
  font-size: 0.85rem;
}

@media (max-width: 600px) {
  .student-page {
    padding: 24px 16px;
  }

  .intro {
    padding: 28px 18px;
  }

  .features {
    grid-template-columns: 1fr;
  }
}
</style>