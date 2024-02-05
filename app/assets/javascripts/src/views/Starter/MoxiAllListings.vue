<template>
  <card class="container">
    <div class="container">
      <div class="row">
        <ul class="col-4" v-for="listing in listings" :key="listing.id">
          <div>
            <b-card
              :title="listing.Address"
              :img-src="listing.ListingImages[0].FullURL"
              img-alt="Image"
              img-top
              tag="article"
              style="height: auto; max-width: 100%;"
              class="mb-2"
            >
            <b-card-text>
              Listing ID: <strong>{{listing.ListingID}}</strong>
            </b-card-text>
            <b-card-text>
              Agent: <strong>{{listing.ListAgentFullName}}</strong>
            </b-card-text>
            <b-card-text>
              ListOfficeAOR: <strong>{{listing.ListOfficeAOR}}</strong>
            </b-card-text>
              <b-card-text>            
              Agent UUID: {{listing.ListAgentUUID}}
              </b-card-text>

              <b-button :href="listing.ListingURL" variant="primary">Listing Page</b-button>
            </b-card>
          </div>
        </ul>
      </div>
    </div>
  </card>
</template>

<script>
import { fetchListingData } from "@/services/AuthenticationService.js";

export default {
  data() {
    return {
      listings: null,
      error: null,
    };
  },
  mounted() {
    this.listingData();
  },
  methods: {
    async listingData() {
      const companyId = this.$route.params.moxi_works_company_id;

      try {
        const res = await fetchListingData(companyId);

        if (res.success) {
          console.log(res)
          this.listings = res.data.data.Listings;
        } else {
          this.error = "Failed to retrieve branding data.";
        }
      } catch (error) {
        this.error = "An unexpected error occurred.";
      } finally {
        this.loading = false;
      }
    }
  },
};

</script>

<style>

</style>