import { expect } from 'chai';
import { shallowMount } from '@vue/test-utils';
import RecipeBrowser from '@/components/RecipeBrowser.vue';

const NUMBER_OF_RECIPES_IN_GAME = 114;

describe('RecipeBrowser.vue', () => {
  it('Renders all recipes', () => {
    const wrapper = shallowMount(RecipeBrowser);
    expect(wrapper.findAll('li.recipe').length).to.equal(NUMBER_OF_RECIPES_IN_GAME);
  });
});
