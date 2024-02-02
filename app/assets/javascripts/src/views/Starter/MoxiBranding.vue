<template>
  <div v-if="branding">
    <pre>{{branding}}</pre>
  </div>
</template>

<script>
import {fetchBrandingData} from "@/services/AuthenticationService.js";
export default {
  data() {
    return {
      branding: null
    }
  },
  mounted() {
    this.brandingData();
  },
  methods: {
    async brandingData() {
      const companyId = this.$route.params.moxi_works_company_id;
      console.log('COMPANYID param', companyId)
      try {
        const res = await fetchBrandingData(companyId)
        console.log(res)
        if(res.success) {
          console.log(res)
          this.branding = res.data
        } else {
          console.log('failed to get data from fetchbrandingdata', res.error)
        }
      } catch (error) {
        console.error('error getting data after the try', error)
      }
    }
  }
}
</script>

<style>

</style>