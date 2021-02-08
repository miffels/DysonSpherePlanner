<template>
  <div id="app">
    <RecipeBrowser />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import RecipeBrowser from './components/RecipeBrowser.vue';

@Component({
  components: {
    RecipeBrowser,
  },
})
export default class App extends Vue {}
</script>

<style>
:root {
  --bg: #131516;
  --fg: #d8d4cf;
}

html {
  color: var(--fg);
  background-color: var(--bg);
}

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  margin-top: 60px;
}
</style>
