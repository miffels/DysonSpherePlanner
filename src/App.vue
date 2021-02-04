<template>
  <div id="app">
    <a href="https://store.steampowered.com/app/1366540/Dyson_Sphere_Program/"><img class="logo" src="../data/ui/textures/dsp-logo-en.png"></a>
    <h1>Recipe Browser</h1>
    <i>Not affiliated with, or endorsed by, Youthcat Studio.<br />Made with &#10084;&#65039; &amp; &#127864; in Germany.</i>
    <ul id="example-1">
      <li class="recipe" v-for="recipe in recipes" :key="recipe.ID" @click="show = recipe.ID">
        <div class="result">
          <img :title="i18n[language][recipe.Name]" :src="'../data/' + iconForRecipe(recipe).toLowerCase() + '.png'">
          <span class="recipe-time" v-show="show == recipe.ID && recipe.TimeSpend/60 >=1">{{ recipe.TimeSpend/60 }}s</span>
          <span class="ingredient-count" v-show="show == recipe.ID">{{ resultsForRecipe(recipe)[0].count }}</span>
        </div>
        <div v-show="show == recipe.ID"  class="detail">
          <ul>
            <li v-for="ingredient in ingredientsForRecipe(recipe)" :key="recipe.ID+ingredient.item.ID">
              <div class="ingredient">
                <img :title="i18n[language][ingredient.item.Name]" :src="'../data/' + ingredient.item.IconPath.toLowerCase() + '.png'">
                <span class="ingredient-count">{{ ingredient.count }}</span>
              </div>
            </li>
          </ul>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
const YAML = require("YAML");
import itemProtoSet from "../data/prototypes/ItemProtoSet.asset";
import stringProtoSet from "../data/prototypes/StringProtoSet.asset";
import recipeProtoSet from "../data/prototypes/RecipeProtoSet.asset";

function getData(raw) {
  return YAML.parse(raw).MonoBehaviour.dataArray
}

export default {
  name: 'app',
  data () {

    const items = getData(itemProtoSet);
    const recipes = getData(recipeProtoSet);
    const i18n = getData(stringProtoSet).reduce((acc, i) => {
          acc.ZHCN[i.Name] = i.ZHCN;
          acc.ENUS[i.Name] = i.ENUS;
          acc.FRFR[i.Name] = i.FRFR;
          return acc;
        }, {"ZHCN": {}, "ENUS": {}, "FRFR": {}});
    const itemMap = items.reduce((acc, i) => {
        acc[i.ID] = i;
        return acc;
      }, {});

    function unpackHex(hex) {
      return hex.match(/.{1,8}/g)
        .map(g =>  parseInt([6, 4, 2, 0].map(i => g.substr(i, 2)).join(""), 16));
    }

    function ingredientsForRecipe(recipe) {
      const items = unpackHex(recipe.Items).map(id => itemMap[id]);
      const counts = unpackHex(recipe.ItemCounts);
      return items.reduce((acc, item, idx) => {
        acc.push({
          item,
          count: counts[idx]
        })
        return acc;
      }, []);
    }

    function resultsForRecipe(recipe) {
      const items = unpackHex(recipe.Results).map(id => itemMap[id]);
      const counts = unpackHex(recipe.ResultCounts);
      return items.reduce((acc, item, idx) => {
        acc.push({
          item,
          count: counts[idx]
        })
        return acc;
      }, []);
    }

    return {
      language: "ENUS",
      items,
      i18n,
      recipes,
      iconForRecipe(recipe) {
        return recipe.IconPath || (resultsForRecipe(recipe)[0].item || {}).IconPath || ""
      },
      ingredientsForRecipe,
      resultsForRecipe,
      show: false
    }
  },
  mounted () {
  }
}
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
