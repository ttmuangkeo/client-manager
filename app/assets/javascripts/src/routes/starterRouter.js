import Vue from 'vue';
import Router from 'vue-router';
import SideBar from '../views/Starter/SideBar.vue';


Vue.use(Router);
const router = new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      redirect: '/home',
      component: SideBar,
      children: [      
        {
          path: '/home',
          name: 'home',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/Home.vue')
        },        
        {
          path: '/moxi/login',
          name: 'moxiLogin',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/MoxiLogin.vue')
        },        
        {
          path: '/moxi/company/:username',
          name: 'moxiCompany',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/MoxiCompany.vue'),
          props: true
        },        
        {
          path: '/moxi/branding/:moxi_works_company_id',
          name: 'moxiCompanyBranding',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/MoxiBranding.vue'),
          props: true
        },        
        {
          path: '/moxi/listings/:moxi_works_company_id',
          name: 'moxiListings',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/MoxiListings.vue'),
          props: true
        },        
        {
          path: '/moxi/agents/:moxi_works_company_id',
          name: 'moxiAgents',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/MoxiAgents.vue'),
          props: true
        },        
        {
          path: '/brytecore/company',
          name: 'company',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/BrytecoreCompany.vue')
        },        
        {
          path: '/brytecore/companies/:companyId',
          name: 'getCompanies',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/BrytecoreCompanies.vue'),
          // added required auth to view this page
          // meta: {requiredAuth: true}
        },
        // This component will be a thing if brytecore allows a get ALL company. As far as i know they do not. However if they do will need to build a company page to host all the companies
        {
          path: '/brytecore/login',
          name: 'login',
          component: () => import(/* webpackChunkName: "demo" */ '../views/Starter/BrytecoreLogin.vue'),
          // added required auth to view this page
          // meta: {requiredAuth: true}
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
// logic to require access token to view the companies page
// router.beforeEach((to, from, next) => {
//   if(to.meta.requiredAuth) {
//     const accessToken = store.getters.getAccessToken;
//     if(!accessToken) {
//       next('/');
//     } else {
//       next()
//     }
//   } else {
//     next()
//   }
// })

export default router