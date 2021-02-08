import '@trevoreyre/autocomplete-vue/dist/style.css';
import Autocomplete from '@trevoreyre/autocomplete-vue';
import Vue from 'vue';
import App from './App.vue';

Vue.config.productionTip = false;
Vue.use(Autocomplete);

new Vue({
  render: (h) => h(App),
}).$mount('#app');
