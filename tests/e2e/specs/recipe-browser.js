// https://docs.cypress.io/api/introduction/api.html

class RecipeSearchComponent {
  static visit() {
    cy.visit('/');
  }

  static searchInput = () => cy.get('#recipe-search.autocomplete-input');

  static recipeListItems = () => cy.get('.recipe-list').find('li.recipe');

  static firstRecipe = () => RecipeSearchComponent.recipeListItems().first();

  static firstRecipeDetails = () => RecipeSearchComponent.firstRecipe().find('.detail');

  static search(value) {
    this.searchInput().type(value);
  }
}

const component = RecipeSearchComponent;

describe('Recipe Browser', () => {
  beforeEach(() => {
    component.visit();
  });

  it('Is rendered', () => {
    cy.contains('h2', 'Recipe Browser');
    component.recipeListItems().should('have.length', 114);
  });

  it('Lets you search items', () => {
    component.search('iron');
    component.recipeListItems().should('have.length', 1);
  });

  it('Lets you view recipes', () => {
    component.firstRecipeDetails().should('not.be.visible');
    component.recipeListItems().first().click();
    component.firstRecipeDetails().should('be.visible');
  });
});
