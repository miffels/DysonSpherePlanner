<template>
  <div id="app">

    <h2>Production Planner</h2>
    <autocomplete
      id="production-search"
      :search="searchItems"
      :get-result-value="suggest"
      auto-select
      @submit="addTarget"></autocomplete>
    <ul class="target-list">
      <li class="target"
        v-for="(target, index) in targets"
        :key="index">
        <img class="target-thumbnail"
        :src="'data/' + target.item.IconPath.toLowerCase() + '.png'">
        <span class="target-label">{{i18n[language][target.item.Name]}}</span>
        <input class="target-ppm" type="number" :value="target.perMinute">/min
        <button class="target-remove" @click="removeTarget(target)">X</button>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import {
  Item, Language, items, i18n,
} from '../data';

const TICKS_PER_MINUTE = 60 * 60;

interface Target {
  item: Item;
  perMinute: number;
}

@Component
export default class RecipeBrowser extends Vue {
  private items = items;

  private i18n = i18n;

  private language: Language = 'ENUS';

  private targets: Target[] = [];

  private craftingSpeedModifier = 0.75;

  searchItems(query: string): Item[] {
    if (query.length < 1) { return []; }
    const regex = new RegExp(query, 'i');
    return this.items.filter((item) => item.productOf.length > 0
      && (item.Name.match(regex)
      || item.IconPath.match(regex)
      || this.i18n.ZHCN[item.Name].match(regex)
      || this.i18n.ENUS[item.Name].match(regex)
      || this.i18n.FRFR[item.Name].match(regex)));
  }

  suggest(item: Item): string {
    return this.i18n[this.language][item.Name];
  }

  addTarget(item: Item | undefined) {
    if (!item) return;
    const product = item.productOf[0];
    if (this.targets.find((t) => t.item === item)) return;
    this.targets.push({
      item,
      perMinute: (product.count / product.recipe.TimeSpend)
        * TICKS_PER_MINUTE
        * this.craftingSpeedModifier,
    });
  }

  removeTarget(target: Target) {
    this.targets.splice(this.targets.indexOf(target), 1);
  }
}
</script>

<style scoped>
h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

.target-list {
  margin: 2rem 1rem;
}

.target {
  display: flex;
  flex-direction: row;
  vertical-align: middle;
  line-height: 2rem;
}

.target-label {
  margin-left: 1rem;
  width: 20rem;
  text-align: left;
}

.target-thumbnail {
  max-width: 2rem;
}

.target-ppm {
  margin-left: 1rem;
  width: 3rem
}

.target-remove {
  margin-left: 1rem;
}

</style>
