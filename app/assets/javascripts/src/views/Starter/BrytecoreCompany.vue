<template>
  <card class="container">
      <h1>Brytecore</h1>
      <hr>
    <div class="row">
      <div class="col-md center">
        <button @click="createCompany" class="btn btn-info">Create New Company</button>
      </div>
      <div class="col-md">
        <button @click="createApiKey" class="btn btn-info">Create New API Key</button>
      </div>
    </div>
  </card>
</template>

<script>
import BaseHeader from '../../components/BaseHeader.vue';
import StatsCard from '../../components/Cards/StatsCard.vue';
export default {
  components: { BaseHeader, StatsCard },
  data() {
    return {

    };
  },
  mounted() {

  },
  methods: {
      async createCompany() {
        if(!this.$store.getters.getAccessToken) {
          this.$router.push('/brytecore/login');
          return;
        } else {
          // logig to create new company can be put here
          console.log(this.$store.getters.getAccessToken)
        }
      },
      async createApiKey() {
        if(!this.$store.getters.getAccessToken) {
          this.$router.push('/brytecore/login');
          return;
        } else {
          // logic to create an api key can go here
          console.log(this.$store.getters.getAccessToken)
        }
      }
  },
};
</script>

<style>
/* Add your component styles here */
</style>
