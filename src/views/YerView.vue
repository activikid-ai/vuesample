<template>
  <article class="student-page">
    <header class="intro">
      <p class="eyebrow">ACTIVIKID / VUE PRACTICE</p>
      <h1>Hi, I’m Yerdos.</h1>
      <p class="lead">A small space to learn by building.</p>
      <p>I’m working through my first Vue task with the Kaza group.
        Try the examples below to see how a page responds to changing data.</p>
      <a class="source-link" href="https://github.com/activikid-ai/vuesample"
        target="_blank" rel="noopener noreferrer">View our shared repository ↗</a>
    </header>

    <section class="exercise" aria-labelledby="counter-heading">
      <div class="section-heading">
        <span class="step">01</span>
        <div>
          <h2 id="counter-heading">Make a change. See it happen.</h2>
          <p>Each click changes a number. Vue updates the page automatically.</p>
        </div>
      </div>
      <div class="counter">
        <button type="button" class="counter-button" aria-label="Decrease count"
          :disabled="count === 0" @click="count--">−</button>
        <output class="count" aria-live="polite" aria-atomic="true">{{ count }}</output>
        <button type="button" class="counter-button" aria-label="Increase count"
          @click="count++">+</button>
      </div>
      <div class="counter-footer">
        <p>The count stays at zero or above.</p>
        <button type="button" class="text-button" :disabled="count === 0"
          @click="count = 0">Reset counter</button>
      </div>
    </section>

    <section class="exercise" aria-labelledby="learning-heading">
      <div class="section-heading">
        <span class="step">02</span>
        <div>
          <h2 id="learning-heading">Check what you understand.</h2>
          <p>Use this practice checklist as you explore the examples.</p>
        </div>
      </div>
      <div class="progress-heading">
        <label for="learning-progress">Learning progress</label>
        <span aria-live="polite">{{ completedCount }} of {{ topics.length }} checked</span>
      </div>
      <progress id="learning-progress" :value="completedCount" :max="topics.length" />
      <ul class="topics">
        <li v-for="topic in topics" :key="topic.id">
          <label :class="{ checked: topic.done }">
            <input v-model="topic.done" type="checkbox" />
            <span><strong>{{ topic.title }}</strong><span class="topic-description">{{ topic.description }}</span></span>
          </label>
        </li>
      </ul>
      <p v-if="completedCount === topics.length" class="complete" role="status">
        All checked! Try explaining each example in your own words.
      </p>
      <button type="button" class="text-button" :disabled="completedCount === 0"
        @click="resetChecklist">Clear checklist</button>
      <p class="session-note">Practice only: the counter and checklist reset when you reload this page.</p>
    </section>

    <footer class="page-footer">
      <span>YER · First Vue task</span>
      <a href="https://vuejs.org/guide/introduction.html" target="_blank"
        rel="noopener noreferrer">Keep learning with the Vue guide ↗</a>
    </footer>
  </article>
</template>

<script>
export default {
  name: 'YerView',
  data() {
    return {
      count: 0,
      topics: [
        { id: 'components', title: 'Single-file components', description: 'Keep a view’s template, logic and styles in one .vue file.', done: false },
        { id: 'reactivity', title: 'Reactive data and events', description: 'Click the counter buttons and watch the displayed number change.', done: false },
        { id: 'bindings', title: 'Bindings and computed values', description: 'Check a topic and watch the progress update.', done: false },
        { id: 'collaboration', title: 'Working on a personal branch', description: 'Change your own view, then submit a pull request for review.', done: false },
      ],
    }
  },
  computed: {
    completedCount() {
      return this.topics.filter(topic => topic.done).length
    },
  },
  methods: {
    resetChecklist() {
      this.topics.forEach(topic => { topic.done = false })
    },
  },
}
</script>

<style scoped>
.student-page {
  max-width: 800px;
  margin: 0 auto;
  padding: 24px 8px 0;
  text-align: left;
  line-height: 1.6;
  color: #283d3a;
}
.intro { padding-bottom: 40px; max-width: 620px; }
.eyebrow { font-size: .75rem; letter-spacing: .13em; font-weight: 700; color: #466b60; }
h1 { margin: 12px 0; font-size: clamp(2.4rem, 7vw, 3.8rem); line-height: 1.15; letter-spacing: -.045em; }
.lead { font-size: 1.35rem; margin: 16px 0; }
a { color: #176549; text-underline-offset: 4px; }
.source-link { display: inline-block; margin-top: 10px; font-weight: 600; }
.exercise { padding: 28px 0; border-top: 1px solid #d7e3de; }
.section-heading { display: flex; align-items: baseline; gap: 18px; }
.step { color: #526e64; font-size: .85rem; font-weight: 700; }
h2 { margin: 0; font-size: 1.3rem; line-height: 1.4; }
.section-heading p { margin: 8px 0 20px; color: #566761; }
.counter { display: flex; align-items: center; justify-content: center; gap: 32px; padding: 20px; background: #eef5f1; border-radius: 12px; }
button { font: inherit; cursor: pointer; }
.counter-button { width: 48px; height: 48px; border: 1px solid #b6cdc1; border-radius: 50%; background: white; color: #176549; font-size: 1.7rem; line-height: 1; }
.counter-button:hover:enabled { background: #d7ebdf; }
.count { min-width: 3ch; text-align: center; font-size: 3.4rem; font-weight: 700; font-variant-numeric: tabular-nums; overflow-wrap: anywhere; }
.counter-footer, .progress-heading, .page-footer { display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; gap: 8px 16px; }
.counter-footer p { font-size: .85rem; color: #566761; }
.text-button { padding: 10px 0; border: 0; background: transparent; text-decoration: underline; text-underline-offset: 4px; color: #176549; }
button:disabled { opacity: .45; cursor: default; }
button:focus-visible, a:focus-visible, input:focus-visible { outline: 3px solid #24744f; outline-offset: 5px; }
.progress-heading { font-size: .85rem; }
progress { width: 100%; height: 10px; margin: 12px 0; accent-color: #24744f; }
.topics { list-style: none; margin: 0 0 10px; padding: 0; }
.topics li { border-bottom: 1px solid #e4ebe7; }
.topics label { display: flex; align-items: flex-start; gap: 14px; padding: 16px 0; cursor: pointer; }
.topics input { flex-shrink: 0; width: 19px; height: 19px; margin-top: 4px; accent-color: #24744f; }
.topic-description { display: block; color: #566761; font-size: .9rem; margin-top: 4px; }
.checked strong { text-decoration: line-through; color: #526e64; }
.complete { padding: 12px 16px; background: #eef5f1; border-left: 3px solid #24744f; }
.session-note { color: #566761; font-size: .8rem; }
.page-footer { border-top: 1px solid #d7e3de; padding: 24px 0; font-size: .8rem; color: #566761; }
@media (max-width: 480px) {
  .student-page { padding-top: 8px; }
  .section-heading { gap: 12px; }
  .counter { gap: 16px; }
}
</style>
