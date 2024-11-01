<template>
  <div>
    <div class="header">
      <div>
      <!-- <b-carousel
        id="carousel"
        controls
        indicators
        :img-width="720"
        :img-height="480"
      >
        <b-carousel-slide v-for="image in images" :key="image.id"
          :img-src="image.FullURL"
        ></b-carousel-slide>
      </b-carousel> -->
      </div>      
      <b-container fluid>
        <!-- Mask -->
        <!-- Header container -->
            <span class="mask bg-gradient-default opacity-3"></span>
        <b-container fluid class="d-flex align-items-center">
          <b-row >
            <b-col lg="7" md="10">
              <h1 class="display-2 text-white">{{listing.Address}}</h1>
              <p class="text-white mt-0 mb-5">{{listing.PublicRemarks}}</p>
              <!-- <a href="#!" class="btn btn-info">Edit profile</a> -->
            </b-col>
          </b-row>
        </b-container>
      </b-container>
    </div>

    <b-container fluid class="mt--6">
      <b-row>
        <b-col xl="4" class="order-xl-2 mb-5">
          <user-card :agent-uuid="listing.ListAgentUUID"></user-card>
        </b-col>
        <b-col xl="8" class="order-xl-1">
          <edit-profile-form></edit-profile-form>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import {fetchListingId} from '@/services/AuthenticationService.js';
import EditProfileForm from '@/views/Layout/EditProfileForm.vue';
import UserCard from '@/views/Layout/UserCard.vue';


export default {
  components: {
    EditProfileForm,
    UserCard
  },

  data() {
    return {
      listing: null,
      images: '',
      error: null
    };
  },
  mounted() {
    this.loadListingData();
  },
  methods: {
    async loadListingData() {
      const companyId = this.$route.params.moxi_works_company_id
      const listingId = this.$route.params.moxi_works_listing_id
      try {
        const res = await fetchListingId(listingId, companyId)
        if(res.success){
          console.log(res, 'this is coming from somethin dshjkgbdfhjg ') 
          this.listing = res.data.data
          this.images = res.data.data.ListingImages
        }
      } catch (error) {
        this.error = 'unexpected error occured'
  
      }
    }
  },
};
</script>

<style>
</style>
