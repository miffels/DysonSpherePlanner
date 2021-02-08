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

describe('My First Test', () => {
  beforeEach(() => {
    component.visit();
  });

  it('Visits the app root url', () => {
    cy.contains('h1', 'Recipe Browser');
  });
});
