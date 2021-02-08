import * as YAML from 'yaml';

/* eslint-disable @typescript-eslint/no-var-requires */
const itemProtoSet = require('./assets/data/prototypes/ItemProtoSet.asset').default;
const stringProtoSet = require('./assets/data/prototypes/StringProtoSet.asset').default;
const recipeProtoSet = require('./assets/data/prototypes/RecipeProtoSet.asset').default;
/* eslint-enable @typescript-eslint/no-var-requires */

export type Language = 'ZHCN' | 'ENUS' | 'FRFR';

type ItemMap = {[key: number]: Item};

interface RawRecipe {
  Name: string;
  Items: PackedHex;
  ItemCounts: PackedHex;
  Results: PackedHex;
  ResultCounts: PackedHex;
  IconPath: string;
  TimeSpend: number;
}

export interface Recipe extends RawRecipe {
  // Derived properties
  requires: Ingredient[];
  produces: Result[];
}

export interface Item {
  Name: string;
  ID: number;
  IconPath: string;

  // Derived properties
  productOf: Product[];
}

export interface Ingredient {
  item: Item;
  count: number;
}

export type Result = Ingredient

export type Product = {
  recipe: Recipe;
  count: number;
}

export interface LocalString {
  Name: string;
  ZHCN: string;
  ENUS: string;
  FRFR: string;
}

export interface LocalStringMap {
  ZHCN: {[key: string]: string};
  ENUS: {[key: string]: string};
  FRFR: {[key: string]: string};
}

type PackedHex = string;

function getData<T>(raw: PackedHex): Array<T> {
  return YAML.parse(raw).MonoBehaviour.dataArray;
}

function unpackHex(hex: PackedHex): number[] {
  return (hex.match(/.{1,8}/g) || [])
    .map(
      (g) => parseInt([6, 4, 2, 0].map((i) => g.substr(i, 2)).join(''), 16),
    );
}

export const items = getData<Item>(itemProtoSet).map((item) => ({
  ...item,
  productOf: [],
}));

const itemMap = items.reduce((acc, i) => {
  acc[i.ID] = i;
  return acc;
}, {} as ItemMap);

export const recipes = getData<RawRecipe>(recipeProtoSet).map((rawRecipe) => {
  const ingredients = unpackHex(rawRecipe.Items).map((id) => itemMap[id]);
  const ingredientCounts = unpackHex(rawRecipe.ItemCounts);
  const results = unpackHex(rawRecipe.Results).map((id) => itemMap[id]);
  const resultCounts = unpackHex(rawRecipe.ResultCounts);
  const produces = results.reduce((acc, item, idx: number) => {
    acc.push({
      item,
      count: resultCounts[idx],
    });
    return acc;
  }, [] as Ingredient[]);

  const recipe = {
    ...rawRecipe,
    IconPath: rawRecipe.IconPath || (results[0] || {}).IconPath || 'icons/tech/0.png', // question mark
    requires: ingredients.reduce((acc, item, idx: number) => {
      acc.push({
        item,
        count: ingredientCounts[idx],
      });
      return acc;
    }, [] as Ingredient[]),
    produces,
  };

  produces.forEach((ingredient) => {
    ingredient.item.productOf.push({
      recipe,
      count: ingredient.count,
    });
  });

  return recipe;
});

export const i18n: LocalStringMap = getData<LocalString>(stringProtoSet)
  .reduce((acc, i) => {
    acc.ZHCN[i.Name] = i.ZHCN;
    acc.ENUS[i.Name] = i.ENUS;
    acc.FRFR[i.Name] = i.FRFR;
    return acc;
  }, { ZHCN: { }, ENUS: { }, FRFR: { } } as LocalStringMap);
