<template>
  <div id="app">
    <header class="topbar">
      <nav class="topbar__nav">
        <router-link to="/">Home</router-link>
        <router-link to="/kaza">kaza</router-link>
        <router-link to="/ins">ins</router-link>
        <router-link to="/yer">yer</router-link>
        <router-link to="/zan">zan</router-link>
      </nav>
    </header>
    <main class="page">
      <router-view />
    </main>
  </div>
</template>

<script>
export default {
  name: 'App',
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  min-height: 100vh;
}

body {
  margin: 0;
}

.topbar {
  position: sticky;
  top: 0;
  z-index: 10;
  background: #2c3e50;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
}

.topbar__nav {
  display: flex;
  flex-wrap: wrap;
  gap: 8px 20px;
  justify-content: center;
  align-items: center;
  max-width: 960px;
  margin: 0 auto;
  padding: 14px 16px;
}

.topbar__nav a {
  color: #ffffff;
  text-decoration: none;
  font-weight: 600;
  font-size: 1rem;
  padding: 4px 2px;
  border-bottom: 2px solid transparent;
}

.topbar__nav a:hover {
  color: #42b983;
}

.topbar__nav a.router-link-exact-active {
  color: #42b983;
  border-bottom-color: #42b983;
}

.page {
  padding: 24px 16px 48px;
}
</style>
