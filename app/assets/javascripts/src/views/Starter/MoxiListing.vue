<template>
  <b-container>
    <b-row>
      <b-card class="col-6 center">
        {{ listings }}
      </b-card>
    </b-row>
  </b-container>
</template>

<script>
import { fetchListingData } from "@/services/AuthenticationService.js";

export default {
  data() {
    return {
      listings: null,
      loading: true,
      error: null,
    };
  },
  mounted() {
    this.brandingData();
  },
  methods: {
    async brandingData() {
      const companyId = this.$route.params.moxi_works_company_id;
      const listingId = this.$route.params.moxi_works_company_id;

      try {
        const res = await fetchListingData(listingId, companyId);

        if (res.success) {
          this.listings = res.data.data;
        } else {
          this.error = "Failed to retrieve branding data.";
        }
      } catch (error) {
        this.error = "An unexpected error occurred.";
      } finally {
        this.loading = false;
      }
    },
  },
};
</script>

<style>
img {
  height: auto;
  max-width: 100%;
}
</style>
