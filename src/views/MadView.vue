<template>
  <div class="terminal-page">
    <h1 class="eyebrow">Madiyar's page</h1>

    <section class="window" :class="{ 'is-amber': amber }" @click="focusInput">
      <header class="bar">
        <span class="dot dot--red"></span>
        <span class="dot dot--amber"></span>
        <span class="dot dot--green"></span>
        <span class="bar__title">mad@vue: ~</span>
        <span class="bar__status">{{ amber ? 'amber' : 'green' }}</span>
      </header>

      <div ref="screen" class="screen" role="log" aria-live="polite" aria-label="Terminal output">
        <div v-for="line in lines" :key="line.id" class="line" :class="'line--' + line.kind">
          <template v-if="line.kind === 'input'">
            <span class="prompt">{{ prompt }}</span> {{ line.text }}
          </template>
          <template v-else>{{ line.text }}</template>
        </div>

        <div class="line line--live">
          <span class="prompt">{{ prompt }}</span>
          <input
            ref="input"
            v-model="input"
            class="cmd"
            type="text"
            autocomplete="off"
            autocapitalize="off"
            spellcheck="false"
            :disabled="booting"
            :placeholder="booting ? 'booting…' : 'type a command…'"
            aria-label="Type a command and press Enter"
            @keydown="onKeydown"
          />
        </div>
      </div>

      <footer class="bar bar--foot">
        <span>↑ ↓ history</span>
        <span>tab completes</span>
        <span>ctrl + l clears</span>
        <span class="bar__status">vue 3</span>
      </footer>
    </section>
  </div>
</template>

<script>
const COMMANDS = [
  ['help', 'this list'],
  ['whoami', 'who made this page'],
  ['stack', 'what it is built with'],
  ['date', 'current date and time'],
  ['theme', 'switch accent: green / amber'],
  ['echo <text>', 'print your text back'],
  ['clear', 'clear the screen (ctrl + l)'],
  ['ls', 'list the files behind this page'],
]

const NAMES = COMMANDS.map(([name]) => name.split(' ')[0])

const BOOT = [
  ['accent', 'madOS 1.0 · personal terminal'],
  ['muted', 'Everything on this page is a single Vue component.'],
  ['muted', 'Type "help" to see what it can do.'],
]

export default {
  name: 'MadView',
  data() {
    return {
      prompt: 'mad@vue:~$',
      lines: [],
      input: '',
      booting: true,
      amber: false,
      alive: true,
      history: [],
      historyIndex: 0,
      draft: '',
      nextId: 1,
    }
  },
  mounted() {
    this.boot()
  },
  beforeUnmount() {
    this.alive = false
  },
  methods: {
    async boot() {
      const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches

      for (const [kind, text] of BOOT) {
        const line = this.push(kind, reduced ? text : '')
        if (reduced) continue

        for (const char of text) {
          if (!this.alive) return
          line.text += char
          this.scrollToBottom()
          await this.sleep(9)
        }
        await this.sleep(140)
      }

      if (!this.alive) return
      this.booting = false
      await this.$nextTick()
      this.focusInput()
    },

    sleep(ms) {
      return new Promise((resolve) => setTimeout(resolve, ms))
    },

    push(kind, text) {
      const line = { id: this.nextId++, kind, text }
      this.lines.push(line)
      this.$nextTick(this.scrollToBottom)
      return line
    },

    print(kind, text) {
      String(text)
        .split('\n')
        .forEach((part) => this.push(kind, part))
    },

    scrollToBottom() {
      const screen = this.$refs.screen
      if (screen) screen.scrollTop = screen.scrollHeight
    },

    focusInput() {
      const input = this.$refs.input
      if (input && !this.booting) input.focus()
    },

    runCommand(raw) {
      const text = raw.trim()
      if (!text) return

      this.push('input', text)
      if (this.history[this.history.length - 1] !== text) this.history.push(text)
      this.historyIndex = this.history.length

      const [name, ...args] = text.split(/\s+/)
      const command = name.toLowerCase()

      switch (command) {
        case 'help':
          this.print('muted', 'available commands')
          COMMANDS.forEach(([cmd, description]) => {
            this.print('output', `  ${cmd.padEnd(13)}${description}`)
          })
          break

        case 'whoami':
          this.print('output', 'madiyar')
          break

        case 'stack':
          this.print('output', 'Vue 3 — components, router, reactivity')
          this.print('output', 'JavaScript — modules, async/await, arrays')
          this.print('output', 'CSS — grid, flex, custom properties')
          this.print('output', 'Git — branches, commits, pull requests')
          break

        case 'date':
          this.print(
            'output',
            new Date().toLocaleString([], { dateStyle: 'full', timeStyle: 'short' })
          )
          break

        case 'theme':
          this.amber = !this.amber
          this.print('accent', `accent: ${this.amber ? 'amber' : 'green'}`)
          break

        case 'echo':
          this.print(args.length ? 'output' : 'muted', args.join(' ') || 'echo: nothing to echo')
          break

        case 'ls':
          this.print('output', 'src/App.vue\nsrc/router/index.js\nsrc/views/MadView.vue   ← this page')
          break

        case 'clear':
          this.lines = []
          break

        case 'sudo':
          this.print('error', 'sudo: permission denied. nice try, though.')
          break

        default:
          this.print('error', `command not found: ${command} — type "help"`)
      }
    },

    onKeydown(event) {
      if (event.key === 'Enter') {
        event.preventDefault()
        const raw = this.input
        this.input = ''
        this.runCommand(raw)
        return
      }

      if (event.key === 'ArrowUp') {
        event.preventDefault()
        this.historyBack()
        return
      }

      if (event.key === 'ArrowDown') {
        event.preventDefault()
        this.historyForward()
        return
      }

      if (event.key === 'Tab') {
        event.preventDefault()
        this.complete()
        return
      }

      if (event.key.toLowerCase() === 'l' && event.ctrlKey) {
        event.preventDefault()
        this.lines = []
      }
    },

    historyBack() {
      if (!this.history.length) return
      if (this.historyIndex === this.history.length) this.draft = this.input
      this.historyIndex = Math.max(0, this.historyIndex - 1)
      this.input = this.history[this.historyIndex]
    },

    historyForward() {
      if (!this.history.length) return
      if (this.historyIndex < this.history.length - 1) {
        this.historyIndex += 1
        this.input = this.history[this.historyIndex]
        return
      }
      this.historyIndex = this.history.length
      this.input = this.draft
    },

    complete() {
      const partial = this.input.trim().toLowerCase()
      if (!partial || partial.includes(' ')) return

      const matches = NAMES.filter((name) => name.startsWith(partial))
      if (matches.length === 1) {
        this.input = `${matches[0]} `
      } else if (matches.length > 1) {
        this.print('muted', matches.join('   '))
      }
    },
  },
}
</script>

<style scoped>
.terminal-page {
  max-width: 780px;
  margin: 0 auto;
  padding: 4px 0 24px;
}

.eyebrow {
  margin: 0 0 10px 4px;
  font-size: 0.75rem;
  font-weight: 700;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: #7a8a9a;
}

.window {
  --accent: #3ddc97;
  --glow: rgba(61, 220, 151, 0.16);
  --ink: #c9d6e3;
  --muted: #6b7d90;
  --red: #ff7b72;

  position: relative;
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 14px;
  background: #0b0f14;
  box-shadow:
    0 24px 60px -28px rgba(11, 15, 20, 0.75),
    0 0 70px -30px var(--glow);
  color: var(--ink);
  font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, 'Liberation Mono', monospace;
  text-align: left;
  cursor: text;
}

.window.is-amber {
  --accent: #ffb86b;
  --glow: rgba(255, 184, 107, 0.16);
}

.window::before {
  content: '';
  position: absolute;
  inset: 0;
  background: radial-gradient(
    620px 200px at 50% -80px,
    var(--glow),
    transparent 70%
  );
  pointer-events: none;
}

.window::after {
  content: '';
  position: absolute;
  inset: 0;
  background: repeating-linear-gradient(
    180deg,
    rgba(255, 255, 255, 0.035) 0 1px,
    transparent 1px 3px
  );
  opacity: 0.4;
  pointer-events: none;
}

.window:focus-within {
  border-color: var(--accent);
}

.bar {
  position: relative;
  z-index: 1;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 14px;
  background: #0e141b;
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}

.dot {
  width: 11px;
  height: 11px;
  border-radius: 50%;
}

.dot--red {
  background: #ff5f57;
}

.dot--amber {
  background: #febc2e;
}

.dot--green {
  background: #28c840;
}

.bar__title {
  margin-left: 8px;
  font-size: 0.76rem;
  color: var(--muted);
}

.bar__status {
  margin-left: auto;
  font-size: 0.68rem;
  font-weight: 700;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: var(--accent);
}

.bar--foot {
  gap: 18px;
  padding: 8px 14px;
  border-top: 1px solid rgba(255, 255, 255, 0.06);
  border-bottom: none;
  background: #0b1016;
  font-size: 0.7rem;
  color: var(--muted);
}

.screen {
  position: relative;
  z-index: 1;
  height: min(58vh, 460px);
  padding: 16px 18px 22px;
  overflow-y: auto;
  overscroll-behavior: contain;
  font-size: 0.92rem;
  line-height: 1.62;
  scrollbar-width: thin;
  scrollbar-color: #2a3644 transparent;
}

.screen::-webkit-scrollbar {
  width: 8px;
}

.screen::-webkit-scrollbar-thumb {
  border-radius: 99px;
  background: #26313d;
}

.line {
  white-space: pre-wrap;
  word-break: break-word;
}

.line--live {
  display: flex;
  align-items: baseline;
  gap: 1ch;
  white-space: pre-wrap;
}

.line--input {
  color: #eaf2fb;
}

.line--output {
  color: var(--ink);
}

.line--muted {
  color: var(--muted);
}

.line--accent {
  color: var(--accent);
}

.line--error {
  color: var(--red);
}

.prompt {
  color: var(--accent);
  font-weight: 600;
}

.cmd {
  flex: 1 1 auto;
  width: auto;
  min-width: 0;
  padding: 0;
  border: none;
  outline: none;
  background: transparent;
  color: #eaf2fb;
  font: inherit;
  caret-color: var(--accent);
}

.cmd::placeholder {
  color: var(--muted);
  opacity: 0.6;
}

@media (max-width: 640px) {
  .screen {
    height: min(64vh, 440px);
    padding: 14px 14px 18px;
    font-size: 0.84rem;
  }

  .bar--foot {
    flex-wrap: wrap;
    gap: 10px;
    font-size: 0.65rem;
  }

  .bar__status {
    margin-left: 0;
  }
}
</style>
