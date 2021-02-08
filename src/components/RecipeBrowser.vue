<template>
  <div id="app">
    <a href="https://store.steampowered.com/app/1366540/Dyson_Sphere_Program/">
      <img class="logo" src="data/ui/textures/dsp-logo-en.png">
    </a>
    <h1>Recipe Browser</h1>
    <i>
      Not affiliated with, or endorsed by, Youthcat Studio.<br />
      Made with &#10084;&#65039; &amp; &#127864; in Germany.
    </i>
    <ul id="example-1">
      <li class="recipe"
        v-for="recipe in recipes"
        :key="recipe.ID"
        @click="show = recipe.ID">
        <div class="result">
          <img
            :title="i18n[language][recipe.Name]"
            :src="'data/' + iconForRecipe(recipe).toLowerCase() + '.png'">
          <span class="recipe-time"
            v-show="show == recipe.ID && recipe.TimeSpend/60 >=1">
            {{ recipe.TimeSpend/60 }}s
          </span>
          <span class="ingredient-count"
            v-show="show == recipe.ID">
            {{ resultsForRecipe(recipe)[0].count }}
          </span>
        </div>
        <div v-show="show == recipe.ID"  class="detail">
          <ul>
            <li
              v-for="ingredient in ingredientsForRecipe(recipe)"
              :key="recipe.ID+ingredient.item.ID">
              <div class="ingredient">
                <img
                  :title="i18n[language][ingredient.item.Name]"
                  :src="'data/' + ingredient.item.IconPath.toLowerCase() + '.png'">
                <span class="ingredient-count">{{ ingredient.count }}</span>
              </div>
            </li>
          </ul>
        </div>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';
import * as YAML from 'yaml';

/* eslint-disable @typescript-eslint/no-var-requires */
const itemProtoSet = require('../assets/data/prototypes/ItemProtoSet.asset').default;
const stringProtoSet = require('../assets/data/prototypes/StringProtoSet.asset').default;
const recipeProtoSet = require('../assets/data/prototypes/RecipeProtoSet.asset').default;
/* eslint-enable @typescript-eslint/no-var-requires */

type PackedHex = string;

interface Recipe {
  Items: PackedHex;
  ItemCounts: PackedHex;
  Results: PackedHex;
  ResultCounts: PackedHex;
  IconPath: string;
}

interface Item {
  ID: number;
  IconPath: string;
}

interface Ingredient {
  item: Item;
  count: number;
}

type Result = Ingredient

interface LocalString {
  Name: string;
  ZHCN: string;
  ENUS: string;
  FRFR: string;
}

interface LocalStringMap {
  ZHCN: {[key: string]: string};
  ENUS: {[key: string]: string};
  FRFR: {[key: string]: string};
}

type Language = 'ZHCN' | 'ENUS' | 'FRFR';

@Component
export default class RecipeBrowser extends Vue {
  private items: Item[] = RecipeBrowser.getData<Item>(itemProtoSet);

  private itemMap = this.items.reduce((acc, i) => {
    acc[i.ID] = i;
    return acc;
  }, {} as {[key: number]: Item});

  private recipes: Recipe[] = RecipeBrowser.getData<Recipe>(recipeProtoSet);

  private i18n: LocalStringMap = RecipeBrowser.getData<LocalString>(stringProtoSet)
    .reduce((acc, i) => {
      acc.ZHCN[i.Name] = i.ZHCN;
      acc.ENUS[i.Name] = i.ENUS;
      acc.FRFR[i.Name] = i.FRFR;
      return acc;
    }, { ZHCN: { }, ENUS: { }, FRFR: { } } as LocalStringMap);

  private language: Language = 'ENUS';

  private show = 0;

  private static getData<T>(raw: PackedHex): Array<T> {
    return YAML.parse(raw).MonoBehaviour.dataArray;
  }

  private static unpackHex(hex: PackedHex): number[] {
    return (hex.match(/.{1,8}/g) || [])
      .map(
        (g) => parseInt([6, 4, 2, 0].map((i) => g.substr(i, 2)).join(''), 16),
      );
  }

  private ingredientsForRecipe(recipe: Recipe): Ingredient[] {
    const ingredients = RecipeBrowser.unpackHex(recipe.Items).map((id) => this.itemMap[id]);
    const counts = RecipeBrowser.unpackHex(recipe.ItemCounts);
    return ingredients.reduce((acc, item, idx: number) => {
      acc.push({
        item,
        count: counts[idx],
      });
      return acc;
    }, [] as Ingredient[]);
  }

  private resultsForRecipe(recipe: Recipe): Result[] {
    const results: Item[] = RecipeBrowser.unpackHex(recipe.Results).map((id) => this.itemMap[id]);
    const counts: number[] = RecipeBrowser.unpackHex(recipe.ResultCounts);
    return results.reduce((acc, item, idx: number) => {
      acc.push({
        item,
        count: counts[idx],
      });
      return acc;
    }, [] as Result[]);
  }

  private iconForRecipe(recipe: Recipe): string {
    return recipe.IconPath || (this.resultsForRecipe(recipe)[0].item || {}).IconPath || '';
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
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

.recipe {
  vertical-align: top;
  margin-top: .5rem;
}

.ingredient {
  background-color: #333;
  border-radius: 1rem;
  display: flex;
  width: 100px;
  height: 100px;
  margin-top: .5rem;
}

.recipe-time {
  align-self: flex-start;
  margin-left: -1rem;
  margin-top: 0.3rem;
  color: rgb(255, 248, 195);
  font-weight: bold;
  vertical-align: top;
}

.ingredient-count {
  align-self: flex-end;
  margin-left: -1rem;
  margin-bottom: 0.3rem;
  color: rgb(175, 255, 255);
  font-weight: bold;
}

a {
  color: #42b983;
}

img.logo {
  max-width: 80%;
}
</style>
