<template>
  <card class="container">
      <div class="col-sm">
        <base-input v-model="searchListingId" label="listingId" placeholder="listingId" type="text"></base-input>
      </div>
      <div class="container" v-if="loading">
        loading...
    </div>
      <div class="row">
        <ul class="col-4" v-for="listing in listings" :key="listing.id">
          <div>
            <!-- <b-card
              :title="listing.Address"
              :img-src="listing.ListingImages[0].FullURL"
              img-alt="Image"
              img-top
              tag="article"
              style="height: auto; max-width: 100%;"
              class="mb-2"
            > -->
            <b-card-text>
              Listing ID: <strong>{{listing.ListingID}}</strong>
              <p>{{ listing.LastUpdated }}</p>
            </b-card-text>
            <b-card-text>
              Agent: <strong>{{listing.ListAgentFullName}}</strong>
            </b-card-text>
            <b-card-text>
              ListOfficeAOR: <strong>{{listing.ListOfficeAOR}}</strong>
            </b-card-text>
              <b-card-text>            
              Agent UUID: <strong>{{listing.ListAgentUUID}}</strong>
              </b-card-text>
              <b-button :href="listing.ListingURL" variant="primary">Listing Page</b-button>
              <b-button @click="redirectListingId(listing.ShortMoxiWorksListingId)" variant="primary">More Info</b-button>
            </b-card>
          </div>
        </ul>
      </div>
  </card>
</template>

<script>
import { fetchListingData, fetchListingId } from "@/services/AuthenticationService.js";

export default {
  data() {
    return {
      listings: null,
      error: null,
      loading: true,
      searchListingId: '',
      listingId: ''
    };
  },
  mounted() {
    this.allListingData();
  },
  methods: {
    async allListingData() {
      const companyId = this.$route.params.moxi_works_company_id;

      try {
        const res = await fetchListingData(companyId);

        if (res.success) {
          console.log(res, "comign from all lsitings page")
          this.loading =true
          this.listings = res.data.data.Listings;
          console.log(this.listings, 'all my listings after it was decalrewd')
        } else {
          this.error = "Failed to retrieve branding data.";
        }
      } catch (error) {
        this.error = "An unexpected error occurred.";
      } finally {
        this.loading = false;
      }
    },
    async redirectListingId(listingId) {
      const companyId = this.$route.params.moxi_works_company_id
      try {
        const res = await fetchListingId(listingId, companyId)
        if(res.success)
        
        this.$router.push({
          name: 'moxiListing',
          params: {
            moxi_works_company_id: companyId,
            moxi_works_listing_id: listingId
          }
        })
      } catch (error) {
        this.error = 'unexpected error occured'
        
      }
    }
  }
};

</script>

<style>

</style>