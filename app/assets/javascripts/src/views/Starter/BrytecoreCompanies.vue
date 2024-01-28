<!-- CompanyData.vue -->
<template>
  <div>
    <base-header class="pt-md-5 bg-transparent">
      <h1>{{company.data.name}}</h1>
    </base-header>
    <hr>  
    <b-container fluid>
      <h2>Company Info:</h2>
      <b-row>
        <b-col xl="3" class="order-xl-6">
          <stats-card>
              companyID: {{company.data.companyId}}
          </stats-card>
          <stats-card>
            <p>
              Team Email: {{company.data.teamEmail}}
            </p>
            <p>
              Vendor ID: {{company.data.vendorCompanyId}}
            </p>
          </stats-card>
        </b-col>
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
      </b-row>
    </b-container>
  </div>
</template>

<script>
import BaseHeader from '../../components/BaseHeader.vue';
import StatsCard from '../../components/Cards/StatsCard.vue';
export default {
  components: { BaseHeader, StatsCard },
  data() {
    return {
      success: false,
      company: {},
      apiKeys: {},
      error: '',
    };
  },
  mounted() {
    const companyId = this.$route.params.companyId;
    this.fetchCompanyData(companyId);
  },
  methods: {
      async fetchCompanyData(companyId) {
      try {
        const accessToken = this.$store.getters.getAccessToken;
        const response = await fetch(`http://localhost:3000/companies/${companyId}`, {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${accessToken}`,
          },
        });

        if (!response.ok) {
          throw new Error('Failed to fetch company data');
        }

        const result = await response.json();
        this.success = true;
        this.company = result.data;

        this.fetchApiKeys(companyId);
      } catch (error) {
        this.success = false;
        this.error = 'An error occurred while fetching company data.';
        console.error('Error:', error);
      }
    },
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
  },
};
</script>

<style>
/* Add your component styles here */
</style>
