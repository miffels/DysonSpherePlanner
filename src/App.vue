<template>
  <div id="app">
    <div class="content">
      <a href="https://store.steampowered.com/app/1366540/Dyson_Sphere_Program/">
        <img class="logo" src="data/ui/textures/dsp-logo-en.png">
      </a>
      <h1>Tools</h1>
      Not affiliated with, or endorsed by, Youthcat Studio.<br />
      Made with &#10084;&#65039; &amp; &#127864; in Germany.
      <!-- <ProductionPlanner /> -->
      <RecipeBrowser />
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import RecipeBrowser from './components/RecipeBrowser.vue';
import ProductionPlanner from './components/ProductionPlanner.vue';

@Component({
  components: {
    RecipeBrowser,
    ProductionPlanner,
  },
})
export default class App extends Vue {}
</script>

<style>
:root {
  --bg: #181a1b;
  --fg: #e8e6e3;
}

html, body, input, textarea, select, button {
  color: var(--fg);
  background-color: var(--bg);
}

img.logo {
  max-width: 80%;
}

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  margin: 5rem 1rem 1rem 1rem;
}

.content {
  text-align: center;
  max-width: 120rem;
  align-self: center;
  margin: 0 auto;
}

.autocomplete {
  margin: 1rem auto;
  max-width: 120rem;
}

.autocomplete-input {
  border-color: rgb(53, 57, 59);
  background-color: rgb(34, 36, 38);
}

.autocomplete-input:focus, .autocomplete-input[aria-expanded="true"] {
    border-color: rgba(140, 130, 115, 0.12);
    background-color: rgb(24, 26, 27);
    outline-color: initial;
}

.autocomplete-result-list {
  background-color: rgb(24, 26, 27);
}
</style>
