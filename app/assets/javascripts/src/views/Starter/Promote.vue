<template>
  <div>
    <input v-model="companyId" placeholder="Company UUID" />
    <input v-model="listingId" placeholder="Listing ID" />
    {{ companyId }}
    {{ listingId }}
    {{ error }}
    <ul>
      <li>
        Listing ID:
        {{ listing.ShortMoxiWorksListingId }}
      </li>
      <li v-if="isLoaded">
        Listing Image URL:
        {{ listing.ListingImages[0].FullURL }}
      </li>
      <li>
        List Agent Moxi Office ID:
        {{ listing.ListAgentMoxiWorksOfficeID }}
      </li>
      <li>
        List Agent UUID:
        {{ listing.ListAgentUUID }}
      </li>
      <li>
        Listing Status:
        {{ listing.Status }}
      </li>
      <li>
        List Price:
        {{ listing.ListPrice }}
      </li>
      <li>
        Listing Address:
        {{ listing.Address }}
      </li>
      <li>
        City:
        {{ listing.City }}
      </li>
      <li>
        State / Province:
        {{ listing.StateOrProvince }}
      </li>
      <li>
        Country Code:
        {{ listing.CountryCode }}
      </li>
      <li>
        Postal Code:
        {{ listing.PostalCode }}
      </li>
      <li>
        Listing Latitude:
        {{ listing.Latitude }}
      </li>
      <li>
        Listing Longitude:
        {{ listing.Longitude }}
      </li>
    </ul>
    <!--<button @click="pullListingData(companyId, listingId)">Check Listing</button>-->
    <button @click="pullListingData()">Check Listing</button>
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
      isLoaded: false
    };
  },
  methods: {
    
    /*async pullListingData(companyId, listingId) {
      // /moxi/company/listing/:moxi_works_listing_id/:moxi_works_company_id
      try {
        // const res = await axios.get(`/moxi/company/listing/${listingId}/${companyId}`);
        const res = await axios.get(`/moxi/company/listings/184950370/4227244`);
        console.log("listing ID:", listingId, "Company ID:", companyId)
        console.log(res);
      } catch(error) {
        console.log(error);
      }
    },*/
    async pullListingData() {
      // /moxi/company/listing/:moxi_works_listing_id/:moxi_works_company_id
      try {
        // const res = await axios.get(`/moxi/company/listing/${listingId}/${companyId}`);
        const res = await axios.get(`/moxi/company/listing/184950370/4227244`);
        if (res.status === 200) {
            this.listing = res.data.data
        }
        console.log(res);
      } catch (error) {
        console.log(error);
      }
      finally {
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