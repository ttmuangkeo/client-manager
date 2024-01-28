<!-- CompanyData.vue -->
<template>
  <div>
    <base-header class="pt-md-5 bg-transparent">
      <h1>{{data.data.name}}</h1>
    </base-header>
    <hr>  
    <b-container fluid>
      <b-row>
        <b-col xl="4" class="order-xl-1">
          <stats-card >
            companyID: {{data.data.companyId}}
          </stats-card>
          <stats-card>
            Team Email: {{data.data.teamEmail}}
          </stats-card>
          <stats-card>
            Vendor ID: {{data.data.vendorCompanyId}}
          </stats-card>
          <stats-card>
            Team Name: {{data.data.teamName}}
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
      data: {},
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
        this.data = result.data;
      } catch (error) {
        this.success = false;
        this.error = 'An error occurred while fetching company data.';
        console.error('Error:', error);
      }
    }
  },
};
</script>

<style>
/* Add your component styles here */
</style>
