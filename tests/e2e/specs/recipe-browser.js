// https://docs.cypress.io/api/introduction/api.html

class RecipeSearchComponent {
  static visit() {
    cy.visit('/');
  }

  static searchInput = () => cy.get('#search');

  static search(value) {
    this.searchInput().value(value);
  }
}

const component = RecipeSearchComponent;

describe('Recipe Browser', () => {
  beforeEach(() => {
    component.visit();
  });

  it('Is rendered', () => {
    cy.contains('h1', 'Recipe Browser');
  });
});
