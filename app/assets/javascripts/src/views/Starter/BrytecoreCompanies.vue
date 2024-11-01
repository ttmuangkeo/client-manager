<template>
  <card class="container">
      <h1>Brytecore</h1>
      <hr>
    <div class="row">
      <div class="col-md center">
        <button @click="createNewCompany('brytecoreCreateCompany')" class="btn btn-info">Create New Company</button>
      </div>
    </div>
    <hr>
    <div class="container">
      <div class="row">
        <ul class="col-4" v-for="companies in company" :key="companies.id">
          <b-card class="mb-3">
            <b-card-text><strong>Name:</strong> {{ companies.name }}</b-card-text>
            <b-card-text
              ><strong>ID:</strong>
              {{ companies.companyId }}</b-card-text
            >
            <b-card-text>
              <strong>External ID:</strong>
              {{ companies.externalId }}
            </b-card-text>
            <div>
              <b-dropdown id="dropdown" text="Info" class="m-md-2">
                <b-dropdown-item
                  @click="redirectTo('getCompanyApiKey', companies.companyId)">View API Keys
                </b-dropdown-item>
              </b-dropdown>
            </div>            
          </b-card>
        </ul>
      </div>
      <div class="pagination-controls">
        <button @click="previousPage" :disabled="currentPage === 1" class="btn btn-primary">Previous</button>
        <span>Page {{ currentPage }} of {{ totalPages }}</span>
        <button @click="nextPage" :disabled="currentPage === totalPages" class="btn btn-primary">Next</button>
      </div>


    </div>
    <!-- <div v-else>
      <router-link :to="{name: 'moxiLogin'}">login</router-link>
    </div> -->
  </card>
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
      error: '',
      currentPage: 1,
      perPage: 10,
      totalPages: 1
    };
  },
  mounted() {
    this.fetchCompanyData();
  },
  methods: {
      async fetchCompanyData() {
      try {
        const accessToken = this.$store.getters.getAccessToken;
        const response = await fetch(`http://localhost:3000/companies?page=${this.currentPage}&per_page=${this.perPage}`, {
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
        this.company = result.companies;
        this.totalPages = result.total_pages;
        console.log(result)

      } catch (error) {
        this.success = false;
        this.error = 'An error occurred while fetching company data.';
        console.error('Error:', error);
      }
    },
    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage += 1;
        this.fetchCompanyData();
      }
    },
    previousPage() {
      if (this.currentPage > 1) {
        this.currentPage -= 1;
        this.fetchCompanyData();
      }
    },    
    createNewCompany(route) {
      this.$router.push({
        name: route
      })
    },
    redirectTo(route, companyId) {
      console.log('from companies page', route, companyId)
      this.selectedCompanyId = companyId;
      this.$router.push({
        name: route,
        params: { companyId },
      });
    }    
  }
};
</script>

<style>
/* Add your component styles here */
</style>
