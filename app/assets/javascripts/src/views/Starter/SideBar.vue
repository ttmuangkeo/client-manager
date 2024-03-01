<template>
  <div class="wrapper">
    <notifications></notifications>
    <side-bar>
      <template slot="links">
        <sidebar-item
            :link="{
              name: 'Moxi Company',
              path: '/moxi/login'
              }"
            >
        </sidebar-item>
        <sidebar-item
            :link="{
              name: 'Brytecore',
              path: '/brytecore/login'
              }"
            >
        </sidebar-item>
        <sidebar-item
            :link="{
              name: 'Promote',
              path: '/Promote'
              }"
            >
        </sidebar-item>
      </template>

    </side-bar>
    <div class="main-content">
      <!-- <dashboard-navbar :type="$route.meta.navbarType"></dashboard-navbar> -->

      <div @click="$sidebar.displaySidebar(false)">
        <fade-transition :duration="200" origin="center top" mode="out-in">
          <!-- your content here -->
          <router-view></router-view>
        </fade-transition>
      </div>
      <!-- <content-footer v-if="!$route.meta.hideFooter"></content-footer> -->
    </div>
  </div>
</template>
<script>
  /* eslint-disable no-new */
  import PerfectScrollbar from 'perfect-scrollbar';
  import 'perfect-scrollbar/css/perfect-scrollbar.css';

  function hasElement(className) {
    return document.getElementsByClassName(className).length > 0;
  }

  function initScrollbar(className) {
    if (hasElement(className)) {
      new PerfectScrollbar(`.${className}`);
    } else {
      // try to init it later in case this component is loaded async
      setTimeout(() => {
        initScrollbar(className);
      }, 100);
    }
  }

  // import DashboardNavbar from '../Layout/DashboardNavbar.vue';
  // import ContentFooter from './ContentFooter.vue';
  // import DashboardContent from '../Layout/Content.vue';
  import { FadeTransition } from 'vue2-transitions';

  export default {
    components: {
      FadeTransition
    },
    methods: {
      initScrollbar() {
        let isWindows = navigator.platform.startsWith('Win');
        if (isWindows) {
          initScrollbar('sidenav');
        }
      }
    },
    mounted() {
      this.initScrollbar()
    }
  };
</script>
<style lang="scss">
</style>
