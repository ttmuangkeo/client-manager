import Vue from 'vue';
import DashboardPlugin from './plugins/dashboard-plugin';
import App from './App.vue';
import store from './data/Store';
import UUID from 'vue-uuid';
import axios from 'axios';

// router setup
import router from './routes/starterRouter';
import { main } from '@popperjs/core';

// plugin setup
Vue.use(DashboardPlugin, UUID, axios);

/* eslint-disable no-new */
new Vue({
  el: '#app',
  render: h => h(App),
  router,
  axios,
  store,
});