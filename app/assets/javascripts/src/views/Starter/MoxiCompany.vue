<template>
  <card class="container">
    <div class="row">
      <div class="col-sm">
        <base-input
          v-model="username"
          label="Partner Identifier"
          placeholder="2991d0d6-9681-11e8-84cf-0050569c54ad"
          type="text"
        ></base-input>
      </div>
      <div class="col-sm">
        <base-input
          v-model="password"
          label="Partner Secret"
          placeholder="123acb"
          type="password"
        ></base-input>
      </div>
      <div class="row">
        <div class="col-12"></div>
        <div class="col-md-auto">
          <button @click="getData" class="btn btn-success">Get Data</button>
          <div v-if="error" class="danger">{{ error }}</div>
        </div>
      </div>
    </div>
    <div class="container" v-if="companies.length">
      <div class="row">
        <ul class="col-4" v-for="company in companies" :key="company.id">
          <b-card class="mb-3">
            <b-card-text><strong>Name:</strong> {{ company.name }}</b-card-text>
            <b-card-text><strong>Numeric ID:</strong> {{ company.numeric_id }}</b-card-text>
            <b-card-text>
              <strong>Moxi Company ID:</strong>
              {{ company.moxi_works_company_id }}
            </b-card-text>
            <div>
              <b-dropdown id="dropdown-1" text="Regular" class="m-md-2">
                <b-dropdown-item @click="redirectTo('moxiAgents', company.moxi_works_company_id)">Agents</b-dropdown-item>
                <b-dropdown-item @click="redirectTo('moxiListings', company.moxi_works_company_id)">Listings</b-dropdown-item>
                <b-dropdown-item @click="redirectTo('moxiCompanyBranding', company.moxi_works_company_id)">Branding</b-dropdown-item>
              </b-dropdown>
            </div>
          </b-card>
        </ul>
      </div>
    </div>
  </card>
</template>

<script>
import { mapGetters } from "vuex";
import { authenticate } from "@/services/AuthenticationService.js";
import StatsCard from "../../components/Cards/StatsCard.vue";

export default {
  components: {
    StatsCard,
  },
  data() {
    return {
      username: "",
      password: "",
      error: "",
      companies: [],
      selectedCompanyId: null
    };
  },
  computed: {
    ...mapGetters("company", ["getCompanies"]),
  },
  methods: {
    async getData() {
      try {
        console.log("from vue comp", this.username, this.password);
        const result = await authenticate(this.username, this.password);
        if (result.success) {
          console.log("from moxicomaby", result);
          this.error = "";
          this.companies = result.data.data;
          this.$store.dispatch("setCompanies", result.data.data);
        } else {
          this.error = result.error;
        }
      } catch (err) {
        console.log(err);
        this.error = "unexpected error";
      }
    },
    redirectTo(route, moxi_works_company_id) {
      this.selectedCompanyId = moxi_works_company_id;
      this.$router.push({
        name: route, params: {moxi_works_company_id}
      })
    }
  }
};
</script>

<style></style>
