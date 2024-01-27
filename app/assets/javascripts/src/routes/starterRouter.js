import Vue from 'vue';
import Router from 'vue-router';
import SideBar from '../views/Starter/SideBar.vue';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      redirect: '/apikey-generator',
      component: SideBar,
      children: [
        {
          path: 'apikey-generator',
          name: 'apikey generator',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/ApiKeyGenerator.vue')
        },
        {
          path: '/event-generator',
          name: 'event generator',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/EventGenerator.vue')
        },        
        {
          path: '/partner-config',
          name: 'partner config',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/PartnerConfig.vue')
        },        
        {
          path: '/loan/:loanId',
          name: 'getLoan',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/LoanOption.vue')
        },        
        {
          path: '/partner-config-builder',
          name: 'partnerConfigBuilder',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/ConfigBuilder.vue')
        },        
        {
          path: '/brytecore',
          name: 'brytecore',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/Brytecore.vue')
        }        
      ]
    }
  ],
  scrollBehavior: (to, from ,savedPosition) => {
    if (savedPosition) {
      return savedPosition;
    }
    if (to.hash) {
      return { selector: to.hash };
    }
    return { x: 0, y: 0 };
  }
});
