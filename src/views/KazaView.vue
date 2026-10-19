<template>
  <div class="kaza-page">
    <h1>kaza</h1>
    <p class="lead">
      This is a demo for adding an individual page of your own in a shared repo.
    </p>

    <section>
      <h2>Kaza group kickoff</h2>
      <p>Use these links for group info and task tracking:</p>
      <ol>
        <li>
          Wiki:
          <a href="https://act.iflexify.com/mediawiki/index.php/Kaza" target="_blank" rel="noopener">
            https://act.iflexify.com/mediawiki/index.php/Kaza
          </a>
        </li>
        <li>
          Trello:
          <a href="https://trello.com/b/rlPb0fR2/kaza" target="_blank" rel="noopener">
            https://trello.com/b/rlPb0fR2/kaza
          </a>
        </li>
      </ol>
    </section>

    <section>
      <h2>Important: edit ONE file only</h2>
      <p>
        Your page file is already created and wired in the router.
        There is <strong>no shared page file</strong> for students to edit.
        Each person changes <strong>only their own view file</strong>:
      </p>
      <ul>
        <li><code>ins</code> → edit only <code>src/views/InsView.vue</code></li>
        <li><code>yer</code> → edit only <code>src/views/YerView.vue</code></li>
        <li><code>zan</code> → edit only <code>src/views/ZanView.vue</code></li>
      </ul>
      <p class="note">
        Do <strong>not</strong> edit <code>App.vue</code>, <code>router/index.js</code>,
        <code>package.json</code>, or anyone else’s view file.
      </p>
    </section>

    <section>
      <h2>Your task (each student)</h2>
      <ol>
        <li>Create your own GitHub account (if you do not have one).</li>
        <li>
          Create your own branch, e.g.
          <code>ins-vuesample-page</code>,
          <code>yer-vuesample-page</code>,
          <code>zan-vuesample-page</code>.
        </li>
        <li>
          Set git user to your GitHub identity on this machine:
          <pre>git config user.name "your-github-username"
git config user.email "your-email@example.com"</pre>
        </li>
        <li>
          Open <strong>only your one file</strong> and put your page content there
          (see mapping above).
        </li>
        <li>
          Commit and push your branch to GitHub (do not push straight to
          <code>main</code>).
        </li>
      </ol>
    </section>

    <section>
      <h2>Git collaboration (short guide)</h2>
      <p>
        Everyone works in the same repo, but on a personal branch, and each person
        edits a different file. That keeps merges simple.
      </p>
      <pre># 1) clone once
git clone &lt;repo-url&gt;
cd vuesample

# 2) start from latest main
git checkout main
git pull origin main

# 3) create your branch
git checkout -b ins-vuesample-page

# 4) edit ONLY your file, then save
#    example for ins: src/views/InsView.vue
git add src/views/InsView.vue
git commit -m "Update ins page content"

# 5) publish your branch
git push -u origin ins-vuesample-page</pre>
      <ul>
        <li>One branch per person.</li>
        <li>One view file per person.</li>
        <li>Pull <code>main</code> before you start new work.</li>
        <li>Open a Pull Request when your page is ready to merge.</li>
      </ul>
    </section>
  </div>
</template>

<script>
export default {
  name: 'KazaView',
}
</script>

<style scoped>
.kaza-page {
  max-width: 720px;
  margin: 0 auto;
  padding: 8px 8px 40px;
  text-align: left;
  line-height: 1.55;
}

h1 {
  margin: 0 0 12px;
  font-size: 2.25rem;
  color: #2c3e50;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  text-align: center;
}

h2 {
  margin: 28px 0 10px;
  font-size: 1.25rem;
  color: #2c3e50;
}

.lead {
  text-align: center;
  color: #555;
  margin: 0 0 8px;
}

.note {
  background: #fff8e6;
  border-left: 4px solid #e6a800;
  padding: 10px 12px;
}

a {
  color: #25569e;
  word-break: break-all;
}

code {
  background: #f3f5f7;
  padding: 1px 6px;
  border-radius: 4px;
  font-size: 0.92em;
}

pre {
  background: #1e2430;
  color: #e8eef7;
  padding: 14px 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-size: 0.88rem;
  line-height: 1.45;
}

ol, ul {
  padding-left: 1.25rem;
}

li {
  margin: 6px 0;
}
</style>
