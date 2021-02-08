/* eslint-disable */
const YAML = require('yaml');
const { readFile, writeFile } = require('fs').promises;
const { join } = require('path');

function fixStringProtoIndentation() {
  const startRegex = /ZHCN:|ENUS:|FRFR:/;
  const endRegex = /- Name:/;
  const spaceTest = /^ {6,}/;
  const stringProtoPath = 'prototypes/StringProtoSet.asset';

  console.log(`Adjusting indentation in ${stringProtoPath}...`);

  readFile(join('assets/raw', stringProtoPath), 'utf-8').then((data) => {
    const lines = data.split(/\n/);
    let indent = false;
    let cleaned = '';
    for (const line of lines) {
      const starts = startRegex.test(line);
      if (!indent) indent = starts;
      else indent = !endRegex.test(line);
      cleaned += `${indent && !starts && !spaceTest.test(line) ? `  ${line}` : line}\n`;
    }
    // Test if parsing passes now
    console.log(YAML.parse(cleaned).MonoBehaviour.dataArray.length);
    writeFile(join('assets/data', stringProtoPath), cleaned);
  }).catch((e) => console.error(e));
}

function fixRecipeItemRefs() {
  const regex = /(?<=^ {4}(Items|ItemCounts|Results|ResultCounts): )(.*)$/gm;
  const recipeProtoPath = 'prototypes/RecipeProtoSet.asset';

  console.log(`Adjusting string delimiters in ${recipeProtoPath}...`);

  readFile(join('assets/raw', recipeProtoPath), 'utf-8').then((data) => {
    const cleaned = data.replace(regex, "'$2'");
    // Test if parsing passes now
    console.log(YAML.parse(cleaned).MonoBehaviour.dataArray.length);
    writeFile(join('assets/data', recipeProtoPath), cleaned);
  }).catch((e) => console.error(e));
}

fixStringProtoIndentation();
fixRecipeItemRefs();
