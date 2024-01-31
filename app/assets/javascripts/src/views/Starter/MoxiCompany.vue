<template>
  <card class="container">
    <div v-if="isLoggedIn">
      <h1>{{ username }}</h1>
      <button @click="logout" class="btn">logout</button>
    </div>
    <div class="container" v-if="companies.length">
      <div class="row">
        <ul class="col-4" v-for="company in companies" :key="company.id">
          <b-card class="mb-3">
            <b-card-text><strong>Name:</strong> {{ company.name }}</b-card-text>
            <b-card-text
              ><strong>Numeric ID:</strong>
              {{ company.numeric_id }}</b-card-text
            >
            <b-card-text>
              <strong>Moxi Company ID:</strong>
              {{ company.moxi_works_company_id }}
            </b-card-text>
            <div>
              <b-dropdown id="dropdown-1" text="Regular" class="m-md-2">
                <b-dropdown-item
                  @click="
                    redirectTo('moxiAgents', company.moxi_works_company_id)
                  "
                  >Agents</b-dropdown-item
                >
                <b-dropdown-item
                  @click="
                    redirectTo('moxiListings', company.moxi_works_company_id)
                  "
                  >Listings</b-dropdown-item
                >
                <b-dropdown-item
                  @click="
                    redirectTo(
                      'moxiCompanyBranding',
                      company.moxi_works_company_id
                    )
                  "
                  >Branding</b-dropdown-item
                >
              </b-dropdown>
            </div>
          </b-card>
        </ul>
      </div>
    </div>
    <div v-else>
      <router-link :to="{name: 'moxiLogin'}">login</router-link>
    </div>
  </card>
</template>

<script>
import { mapGetters } from "vuex";
import { logout } from "@/services/AuthenticationService.js";
import StatsCard from "../../components/Cards/StatsCard.vue";

export default {
  props:['username', 'companies'],
  components: {
    StatsCard,
  },
  data() {
    return {
      password: "",
      error: "",
      selectedCompanyId: null,
      isLoggedIn: false,
    };
  },
  computed: {
    ...mapGetters("company", ["getCompanies"]),
  },
  methods: {
    async logout() {
      try {
        const result = await logout;
        console.log(result);
        if (result.success) {
          this.password = "";
          this.error = "";
          this.companies = [];
          this.selectedCompanyId = null;
          this.isLoggedIn = false;

          this.$router.push({ name: "moxiCompany" });
        } else {
          console.log(result.error);
        }
      } catch (error) {
        console.log(error);
      }
    },
    redirectTo(route, moxi_works_company_id) {
      this.selectedCompanyId = moxi_works_company_id;
      this.$router.push({
        name: route,
        params: { moxi_works_company_id },
      });
    },
  },
};
</script>

<style></style>
