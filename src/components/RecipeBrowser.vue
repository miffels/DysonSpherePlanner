<template>
  <div id="app">
    <h2>Recipe Browser</h2>
    <autocomplete id="recipe-search" :search="searchItems"></autocomplete>
    <ul class="recipe-list">
      <li class="recipe"
        v-for="(recipe, index) in recipes"
        :key="index"
        @click="show = recipe.ID">
        <div class="result">
          <img
            :title="i18n[language][recipe.Name]"
            :src="'data/' + recipe.IconPath.toLowerCase() + '.png'">
          <span class="recipe-time"
            v-show="show == recipe.ID && recipe.TimeSpend/60 >=1">
            {{ recipe.TimeSpend/60 }}s
          </span>
          <span class="ingredient-count"
            v-show="show == recipe.ID">
            {{ recipe.produces[0].count }}
          </span>
        </div>
        <div v-show="show == recipe.ID" class="detail">
          <ul>
            <li
              v-for="ingredient in recipe.requires"
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
import { Component, Vue } from 'vue-property-decorator';

import {
  Language, i18n, recipes,
} from '../data';

@Component
export default class RecipeBrowser extends Vue {
  private allRecipes = recipes;

  private recipes = this.allRecipes;

  private i18n = i18n;

  private language: Language = 'ENUS';

  private show = 0;

  searchItems(query: string): void[] {
    if (query.length < 1) {
      this.recipes = this.allRecipes;
      return [];
    }
    const regex = new RegExp(query, 'i');
    this.recipes = this.allRecipes.filter((recipe) => recipe.Name.match(regex)
      || recipe.IconPath.match(regex)
      || this.i18n.ZHCN[recipe.Name].match(regex)
      || this.i18n.ENUS[recipe.Name].match(regex)
      || this.i18n.FRFR[recipe.Name].match(regex));

    return [];
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

</style>
