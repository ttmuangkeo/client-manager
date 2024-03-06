<template>
  <card class="container">
    <b-col xl="3" md="6" v-for="(res, key) in this.apiKeys.data" :key="key">
      <stats-card class="mb-4">
        <template slot="footer">
          <p>{{res.name}}</p>
          <p>{{res.apiKey}}</p>
          <p class="text-" v-if="res.trackingKey">Tracking Key</p>
          <p v-if="res.testkey" class="btn">Test Key</p>
        </template>  
      </stats-card>
    </b-col>
  </card>
</template>

<script>
import BaseHeader from '../../components/BaseHeader.vue';
import StatsCard from '../../components/Cards/StatsCard.vue';
export default {
  components: { BaseHeader, StatsCard },
  data() {
    return {
      apiKeys: {}
    };
  },
  mounted() {

  },
  methods: {
    async fetchApiKeys(companyId) {
      try {
        const accessToken = this.$store.getters.getAccessToken;
        const res = await fetch(`http://localhost:3000/apikeys/${companyId}`, {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${accessToken}`
          }
        });

        if(!res.ok) {
          throw new Error('Failed to fetch api keys')
        }

        const result = await res.json();
        console.log(result.data)
        this.apiKeys = result.data
      } catch(err) {
        console.log('Error fetching api keys', err);
      }
    }
  }
};
</script>

<style>
/* Add your component styles here */
</style>
