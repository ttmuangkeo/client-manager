<template>
  <div>

    <card class="container">
      <div class="row">
        <div class="col-sm">
          <base-input
            v-model="companyId"
            label="company UUID"
            placeholder="Company UUID"
          />
        </div>
        <div class="col-sm">
          <base-input
            v-model="listingId"
            label="Listing ID"
            placeholder="Listing ID"
          />
        </div>
        <div class="row">
          <div class="col-12"></div>
          <div class="col-md-auto">
            <button
              class="btn btn-success"
              @click="pullListingData(listingId, companyId)"
            >
              Check Listing
            </button>
            <div v-if="error" class="danger">{{ error }}</div>
          </div>
        </div>
      </div>
    </card>
    <card class="container">
      <ul class="list-group">
        
        <li class="list-group-item py-1">
          Listing ID:
          {{ listing.ShortMoxiWorksListingId }}
        </li>
        <li class="list-group-item py-1"> 
            Listing Image URL:
            <span v-if="isLoaded" v-html="$store.getters.getPulledListingData.ListingImages[0].FullURL"></span>
        </li>
        <li class="list-group-item py-1">
          List Agent Moxi Office ID:
          {{ listing.ListAgentMoxiWorksOfficeID }} ({{
            listing.ListOfficeName
          }})
        </li>
        <li class="list-group-item py-1">
          List Agent UUID:
          {{ listing.ListAgentUUID }} ({{ listing.ListAgentFullName }})
        </li>
        <li class="list-group-item py-1">
          Listing Status:
          {{ listing.Status }}
        </li>
        <li class="list-group-item py-1">
          List Price:
          {{ listing.ListPrice }}
        </li>
        <li class="list-group-item py-1">
          Listing Address:
          {{ listing.Address }}
        </li>
        <li class="list-group-item py-1">
          City:
          {{ listing.City }}
        </li>
        <li class="list-group-item py-1">
          State / Province:
          {{ listing.StateOrProvince }}
        </li>
        <li class="list-group-item py-1">
          Country Code:
          {{ listing.CountryCode }}
        </li>
        <li class="list-group-item py-1">
          Postal Code:
          {{ listing.PostalCode }}
        </li>
        <li class="list-group-item py-1">
          Listing Latitude:
          {{ listing.Latitude }}
        </li>
        <li class="list-group-item py-1">
          Listing Longitude:
          {{ listing.Longitude }}
        </li>
      </ul>
    </card>
  </div>
</template>
  
<script>
import axios from "axios";
export default {
  data() {
    return {
      companyId: "",
      listingId: "",
      error: "",
      listing: {},
      isLoaded: false,
    };
  },
  methods: {
    async pullListingData(listingId, companyId) {
      // /moxi/company/listing/:moxi_works_listing_id/:moxi_works_company_id
      try {
        const res = await axios.get( //https://axios-http.com/docs/intro
          `/moxi/company/listing/${listingId}/${companyId}`
        );
        if (res.status === 200) {
            const storedData = this.$store.commit("setPulledListingData", res.data.data);
            console.log(storedData);
            console.log(this.$store.getters.getPulledListingData);
            console.log(res);
          this.listing = res.data.data;
        }
        console.log(res);
      } catch (error) {
        console.log(error);
      } finally {
        this.isLoaded = true;
      }
    },
  },
};
</script>
  
  <style>
ul {
  list-style-type: none;
}
</style>