<template>
  <b-container v-if="branding">
    <b-row>
      <b-card class="col-6 center" v-if="!loading && !error">
        <card class="mb-4">
          <h1 class="text-center">{{ branding.display_name }}</h1>
          <p class="text-center">display_name</p>
        </card>
        <img :src="branding.image_logo" alt="Company Logo" />
        <p>image_logo</p>
        <card class="mb-4" :style="{ backgroundColor: branding.background_color }">
          <p>Background Color: {{ branding.background_color }}</p>
          <p>Font Color Primary: {{ branding.background_font_color_primary }}</p>
        </card>
        <img :src="branding.image_cma_pdf_logo_header" alt="CMA PDF Logo Header" />
        <p>image_cma_pdf_logo_header</p>
        <hr>
        <p v-html="formatCopyright(branding.copyright)"></p>
      </b-card>
    </b-row>
  </b-container>
</template>

<script>
import { fetchBrandingData } from "@/services/AuthenticationService.js";

export default {
  data() {
    return {
      branding: null,
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

      try {
        const res = await fetchBrandingData(companyId);

        if (res.success) {
          this.branding = res.data.data;
        } else {
          this.error = "Failed to retrieve branding data.";
        }
      } catch (error) {
        this.error = "An unexpected error occurred.";
      } finally {
        this.loading = false;
      }
    },
  formatCopyright(copyright) {
    // Use String.fromCharCode to convert HTML entity to actual character
    return copyright.replace(/&copy;/g, String.fromCharCode(169));
  }    
  },
};
</script>

<style>
img {
  height: auto;
  max-width: 100%;
}
</style>
